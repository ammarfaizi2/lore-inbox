Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUDILHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 07:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUDILHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 07:07:35 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:61162 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261184AbUDILHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 07:07:33 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.5-mm3, cdrom gotcha
Date: Fri, 9 Apr 2004 07:07:32 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404090707.32577.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.9.226] at Fri, 9 Apr 2004 06:07:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

I just rebooted to 2.6.5-mm3 while a cd with the Planet CCRMA image on 
it was in the writer.  It took the boot about 5 seconds to get past 
the IDE1 piece of the scan, and it squawked about the drive having 
'incompatible media'.  I have a line in my rc.local that uses hdparm 
to turn the dma back on after the kernel decides to turn it off, and 
that also spit out a media error although an hdparm -d indicates dma 
is on.  dma works just fine with that drive.

After bootup, I tried to mount the disk, but again got the media error 
and fail message.  Removing the disk and rebooting again, and its all 
working again.

Is this a bug?  Seems like it to me.  Its not something I've noted 
before, but then the drive is usually empty, so this is a new error 
to me and I cannot say when it started happening.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
