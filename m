Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUH3EBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUH3EBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUH3EBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:01:34 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:53740 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267452AbUH3EBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:01:32 -0400
From: jmerkey@comcast.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>
Cc: Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Mon, 30 Aug 2004 04:01:29 +0000
Message-Id: <083020040401.15279.4132A6990005360E00003BAF2200758942970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> On Sul, 2004-08-29 at 17:42, William Lee Irwin III wrote:

> Ok so I can compile with a.out support. End of problem, that makes the
> patch useful and "spec compliant", although the spec compliance is
> irrelevant anyway. The spec doesn't determine what Linux is it's a
> useful reference for normality. Special cases are special cases and you
> harm the system by seeking to stop stuff that works purely for pieces of
> paper.
> 

Amen.  USB 2.0 orinoco wireless drivers seems to have problems when user space
is set to 1GB.  Works grat with 2GB ad 3GB user space settings.  Problem occurs during
any acces to usb_read_device().  This doesn't look like a ABI problem, looks like 
a problem with the USB subsystem.  The serialize semaphore gets stuck for some
reason. 

On the other topic, ABI compliance sounds a little restrictive since this is after all, an 
open source OS.  Most apps get recompiled and I always download open source 
components for Linux.  

:-)

Jeff
