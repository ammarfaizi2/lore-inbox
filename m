Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUKCDXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUKCDXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUKCDXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:23:17 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:36033 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261348AbUKCDXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:23:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-bk12 still hangs when starting X on a radeon 9200 SE card
Date: Tue, 2 Nov 2004 23:23:10 -0400
User-Agent: KMail/1.7
Cc: Helge Hafting <helgehaf@aitel.hist.no>
References: <20041102231638.GA12983@hh.idb.hist.no>
In-Reply-To: <20041102231638.GA12983@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411022223.10049.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.44.149] at Tue, 2 Nov 2004 21:23:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 18:16, Helge Hafting wrote:
>I reported this for 2.6.9, the problem
>still exist in 2.6.10-rc1-bk12
>
>Linux dies if I try to start x on my radeon 9200 SE pci card.
>The screen goes black, and there is no response from the keyboard.
>Even sysrq doesn't work, I have to use the reset button.
>
>2.6.8.1 does not have this problem.  This is an
>opteron machine, running a x86 kernel.
>

Helge:  I'm running the -bk7 kernel here on a 2800XP Athlon, using
that video card.  Other than slower glxgears than I'd like, no
problems with the video.

I'll snip your lspci and insert mine for comparison:

# lspci
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
01:08.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
02:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
02:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)

Are there any noticeable diffs?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
