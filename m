Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbULTR10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbULTR10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULTR1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:27:25 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:48555 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261582AbULTR1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:27:17 -0500
Message-ID: <41C70B67.7020600@nortelnetworks.com>
Date: Mon, 20 Dec 2004 11:27:03 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Ross <chris@tebibyte.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
References: <200412171837_MC3-1-9129-C5E@compuserve.com>
In-Reply-To: <200412171837_MC3-1-9129-C5E@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:

>  Nobody has found an answer for the freezes, which persist even in the latest
> 2.6.10-rc but there's a vm_writeout throttling patch in -ac that I haven't tried.

Heh.  Figures.  Those freezes are what bothers me most, since I've already got a 
patch that protects critical processes from being OOM-killed as long as they're 
sane.

I just want an OOM-killer that is FAST and doesn't lock up the machine.  I don't 
really care what it kills, since it won't be *able* to kill anything really 
critical.

Chris
