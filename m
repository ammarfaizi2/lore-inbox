Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUH3Eqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUH3Eqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUH3Eqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:46:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:42455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266725AbUH3EqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:46:15 -0400
Date: Sun, 29 Aug 2004 21:35:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: jmerkey@comcast.net
Cc: alan@lxorguk.ukuu.org.uk, wli@holomorphy.com, roland@topspin.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-Id: <20040829213500.7f029513.rddunlap@osdl.org>
In-Reply-To: <083020040401.15279.4132A6990005360E00003BAF2200758942970A059D0A0306@comcast.net>
References: <083020040401.15279.4132A6990005360E00003BAF2200758942970A059D0A0306@comcast.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 04:01:29 +0000 jmerkey@comcast.net wrote:

| 
| 
| 
| > On Sul, 2004-08-29 at 17:42, William Lee Irwin III wrote:
| 
| > Ok so I can compile with a.out support. End of problem, that makes the
| > patch useful and "spec compliant", although the spec compliance is
| > irrelevant anyway. The spec doesn't determine what Linux is it's a
| > useful reference for normality. Special cases are special cases and you
| > harm the system by seeking to stop stuff that works purely for pieces of
| > paper.
| > 
| 
| Amen.  USB 2.0 orinoco wireless drivers seems to have problems when user space
| is set to 1GB.  Works grat with 2GB ad 3GB user space settings.  Problem occurs during
| any acces to usb_read_device().  This doesn't look like a ABI problem, looks like 
| a problem with the USB subsystem.  The serialize semaphore gets stuck for some
| reason. 

What kernel version?  I can't even find usb_read_device() in 2.6.9-rc1.

BTW, as someone else requested, please teach your mail client to wrap
lines around column 70-72.  Thanks.

| On the other topic, ABI compliance sounds a little restrictive since this is after all, an 
| open source OS.  Most apps get recompiled and I always download open source 
| components for Linux.  


--
~Randy
