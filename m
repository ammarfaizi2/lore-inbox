Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTKHASl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTKGWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:08:11 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:2294 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264016AbTKGJut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:50:49 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: load 2.4.x binary only module on 2.6
Date: Fri, 7 Nov 2003 04:50:41 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20031106153004.GA30008@ds9.ch> <200311061942.39053.gene.heskett@verizon.net> <200311070528.hA75SFe8006038@turing-police.cc.vt.edu>
In-Reply-To: <200311070528.hA75SFe8006038@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311070450.41360.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.77] at Fri, 7 Nov 2003 03:50:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 November 2003 00:28, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 06 Nov 2003 19:42:39 EST, Gene Heskett said:
>> Dunno.  Card here is a gforce2-mx200, 32megs, your basic throwaway
>> card.  X is 4.1.0, and I'm looking to see if I have the vesafb
>> turned on, but I cannot find that as an option, and a grep of
>> .config comes back empty.
>
>Hmm... I'm using XFree86 4.3.0, which probably makes a big
> difference.
>
>Also, try tweaking the values of NvAGP in the XF86Config-4 file
>(I'm using NvAGP=3, your mileage may vary, depending on whether the
>NVidia AGP support or the agpgart version plays nicer with your
> box).
>
Thats already in there.

>Here's the relevant .config I'm using (oh, and I use 'vga=794' at
>boot, which gives me a 64x160 char display..

Which gave me a blank screen on an earlier boot attempt...
>
>#
># Graphics support
>#
>CONFIG_FB=y  OK
># CONFIG_FB_CYBER2000 is not set
># CONFIG_FB_IMSTT is not set
># CONFIG_FB_VGA16 is not set
>CONFIG_FB_VESA=y  OK
>CONFIG_VIDEO_SELECT=y OK
># CONFIG_FB_HGA is not set
># CONFIG_FB_RIVA is not set  is set y here
># CONFIG_FB_I810 is not set
># CONFIG_FB_MATROX is not set
># CONFIG_FB_RADEON is not set
># CONFIG_FB_ATY128 is not set
># CONFIG_FB_ATY is not set
># CONFIG_FB_SIS is not set
># CONFIG_FB_NEOMAGIC is not set
># CONFIG_FB_3DFX is not set
># CONFIG_FB_VOODOO1 is not set
># CONFIG_FB_TRIDENT is not set
># CONFIG_FB_VIRTUAL is not set
>
>#
># Console display driver support
>#
>CONFIG_VGA_CONSOLE=y  OK
># CONFIG_MDA_CONSOLE is not set
>CONFIG_DUMMY_CONSOLE=y  missing from 2.6.0-test9's xconfig
>CONFIG_FRAMEBUFFER_CONSOLE=y OK
>CONFIG_PCI_CONSOLE=y  missing
># CONFIG_FONTS is not set...is set here
>CONFIG_FONT_8x8=y  No
>CONFIG_FONT_8x16=y  OK
>
>#
># Logo configuration
>#
>CONFIG_LOGO=y  No here for all below
>CONFIG_LOGO_LINUX_MONO=y
>CONFIG_LOGO_LINUX_VGA16=y
>CONFIG_LOGO_LINUX_CLUT224=y
>
>Works for me, hopefully something here will click and we'll figure
> out why it isn't working for you...

I turned on the VESA_FB and fonts and its rebuilding now.  Thanks a 
bunch.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

