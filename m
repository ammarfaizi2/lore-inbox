Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbULVGsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbULVGsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 01:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULVGsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 01:48:14 -0500
Received: from siaag2af.compuserve.com ([149.174.40.136]:54782 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261815AbULVGsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 01:48:12 -0500
Date: Wed, 22 Dec 2004 01:44:56 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac16
To: Con Kolivas <kernel@kolivas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Ross <chris@tebibyte.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>
Message-ID: <200412220147_MC3-1-917A-8A25@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Given that the sysctl is not there in 2.6.9 there is no point exporting the 
> variable only to ignore it. You only need this one liner:

 But I might decide to backport the sysctl later; this way makes it
easier to do.  It also makes it more intuitive to reenable the token
by just changing a #define instead of deleting a line of code.

--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
