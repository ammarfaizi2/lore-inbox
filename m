Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271329AbTHRIIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 04:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271330AbTHRIIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 04:08:17 -0400
Received: from proxyip5.us.army.mil ([140.183.234.119]:38024 "EHLO
	mailrouter.us.army.mil") by vger.kernel.org with ESMTP
	id S271329AbTHRIIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 04:08:16 -0400
Date: Mon, 18 Aug 2003 17:04:20 +0900
From: kenton.groombridge@us.army.mil
Subject: Re: nforce2 lockups
To: Patrick Dreker <patrick@dreker.de>
Cc: Jussi Laako <jussi.laako@pp.inet.fi>,
       Alistair J Strachan <alistair@devzero.co.uk>,
       Clock <clock@twibright.com>, linux-kernel@vger.kernel.org
Message-id: <7a3f387a6ef2.7a6ef27a3f38@us.army.mil>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.17 (built Jun 23 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the kernel recognizes all nforce2 chipsets as revision 162.  That is my bad since I found that seemed to be a common denominator.  Taking shots in the dark. :^)

I will tell you that I know it isn't related to bad hardware.  I used a program that I borrowed from my office (not a cheap program, and it is thorough).  It has loopback plugs for USB, serial, parallel, CDs, etc.  I put in all the loopback plugs and CD, and ran burnin diagnostics nightly for about five days.  It made a total of about 30 complete loops through the hardware.  No problems.  Loaded "the other OS" (I like that) and ran it for three days straight with two different hardware banging programs running and there were no problems.  Ran memtest86 overnight, cycled through the memory a good dozen times, no problems.

I start loading Mandrake 9.1, locks up within the install.  If I am lucky enough to get it installed, it is doomed to lock up in three to five minutes of use.  I have tried every kernel/patch that I know (2.4, 2.6 all with acpi, akmp, pre, bk).  Nothing has helped.  Longest run time, about six hours (because I didn't touch it).

This is a hunch: is it possible that gcc is compiling something a bit wrong?  I know that some instructions when processed in a certain order, can do some wacky things.  Maybe a gcc bug is causing the Athlon processor to caculate some instructions in the right sequence where it sometimes works, and other times doesn't.

The reason I say this, is that I have read a few posts where one person had lock-ups with one distro and not the other.  Kernels are pretty much the same (I think we are all downloading the latest kernel source and building our own kernels), but gcc is different.

Haven't tried it yet, since I am working a project 24/7 that will keep me until the end of the month.  Purchased the Athlon XP Gentoo 1.4 CDs, so will load then and may get some different results.

Ken

----- Original Message -----
From: Patrick Dreker <patrick@dreker.de>
Date: Monday, August 18, 2003 5:02 am
Subject: Re: nforce2 lockups

> >
> > I have ASUS A7N8X Deluxe mobo with nForce2 rev 162 without any 
> problems> (if not counting unability to enabe SiI SATA DMA mode 
> with attached
> > Seagate Barracuda drive).
> 
> I have the exact same Board (except I'm not using SATA), and it's 
> a nightmare. 
> Best uptime so far: a little more than 16 hours. Usually it locks 
> up a lot 
> earlier. When I do network transfers I can cause it to lock within 
> a few 
> minutes. Under "the other OS" it runs without any problems.
> 


