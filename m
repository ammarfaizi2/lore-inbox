Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132022AbRCVNoI>; Thu, 22 Mar 2001 08:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRCVNn7>; Thu, 22 Mar 2001 08:43:59 -0500
Received: from biglinux.tccw.wku.edu ([161.6.10.206]:58006 "EHLO
	biglinux.tccw.wku.edu") by vger.kernel.org with ESMTP
	id <S132022AbRCVNnl>; Thu, 22 Mar 2001 08:43:41 -0500
Date: Thu, 22 Mar 2001 07:42:31 -0600 (CST)
From: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kernel-mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Sound issues with m805lr motheboard
In-Reply-To: <E14g3ub-0002Of-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103220730450.4739-100000@biglinux.tccw.wku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That seems strange. What is realserver failing with ?

It isn't so much failing as it hangs.  I don't know if you have used it
or not.  On a startup of the realserver under a 2.2 kernel here is the
output:
*****************************************************************
RealServer (c) 1995-2000 RealNetworks, Inc. All rights reserved.
Version: RealServer 8 (8.0.0.149)
Platform: linux-2.0-libc6-i386

Creating Server Space...
Calibrating Timers...
Starting RealServer 8.0 Core...
Loading RealServer License Files...

Detecting Number of CPUs...
   Testing 1 CPU(s): 1 CPU Detected, Phew...
   Testing 2 CPU(s): 2 CPUs Not Detected (96% Work Produced)
Testing File Descriptors...
Setting per-process descriptor capacity to 676(1010), 11...

***********************************************************************
it then goes on to load libs and stuff.  Under a 2.4 kernel it gets to the

"Testing 1 CPU(s)" Line and just stops there and sits.  I have tried it on
3 different machines and 5 different installs, all with the same results.

Brent Norris

