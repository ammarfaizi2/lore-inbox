Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUAaEGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 23:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUAaEGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 23:06:04 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:7627 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262130AbUAaEGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 23:06:02 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: oddment in build vs reported version
Date: Fri, 30 Jan 2004 23:06:01 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401302306.01366.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.53.166] at Fri, 30 Jan 2004 22:06:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use a script to build new kernels, and this script controls the 
vmlinuz-version-number-s of the bzImage file copied to /boot when its 
done with the build.  This scripts sets the vmlinuz-x.x.x filename 
correctly:

VER=2.6.2-rc2-mm2
and
cp -f arch/i386/boot/bzImage /boot/vmlinuz-$VER && \

So the vmlinuz is correctly named.

The version number in the makefile is correct:
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 2
EXTRAVERSION =-rc2-mm2

But when the build is all done and rebooted to, uname -a spits this 
out:
Linux coyote.coyote.den 2.6.2-rc2-mm1 #2 Fri Jan 30 11:04:30 EST 2004 
i686 athlon i386 GNU/Linux

WTF?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
