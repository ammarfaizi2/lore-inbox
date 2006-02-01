Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWBAEbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWBAEbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWBAEbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:31:24 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:26777 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964911AbWBAEbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:31:24 -0500
Date: Tue, 31 Jan 2006 23:28:27 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc1-mm4
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601312331_MC3-1-B748-FBF0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200601312146_MC3-1-B74E-D5C4@compuserve.com>

[I forgot to copy linux-kernel]

On Tue, 31 Jan 2006, Chuck Ebbert wrote:

> Does this mean that the SMP lock-switching could write all over discarded
> __init code?
> 

Oops, never mind... it uses _text and _etext to bound the address
range it will touch.

That's the problem with these scripts: they produce false positives and
even worse, they miss real problems.

-- 
Chuck
-- 
Chuck

