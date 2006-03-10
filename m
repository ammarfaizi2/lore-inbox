Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWCJLcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWCJLcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWCJLcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:32:42 -0500
Received: from femail.waymark.net ([206.176.148.84]:16075 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1750768AbWCJLcl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:32:41 -0500
Date: 10 Mar 2006 11:23:18 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: [2.6.16-rc5-git13] Xorg.log difference
To: linux-kernel@vger.kernel.org
Message-ID: <5038a3.6a2ae9@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i see this difference with 2.6.16-rc5-git13 kernel.  more info on request -kp

5c5
< Current Operating System: Linux fret 2.6.16-rc5-git13 #2 Fri Mar 10 10:45:41
2006 i686
---
> Current Operating System: Linux fret 2.6.15.6 #1 Tue Mar 07 13:44:04 2006
i686
13c13
< (==) Log file: "/var/log/Xorg.0.log", Time: Fri Mar 10 04:49:26 2006
---
> (==) Log file: "/var/log/Xorg.0.log", Time: Fri Mar 10 05:02:35 2006
327,337c327,383
< (EE) ATI(0): unknown type(0xffffffff)=0xff
< (II) ATI(0): EAX=0x00004f00, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
< (II) ATI(0): ESP=0x00000ffa, EBP=0x00000000, ESI=0x00000000, EDI=0x00002000
< (II) ATI(0): CS=0xc000, SS=0x0100, DS=0x0040, ES=0x0000, FS=0x0000, GS=0x0000
< (II) ATI(0): EIP=0x00001306, EFLAGS=0x00003200
< (II) ATI(0): code at 0x000c1306:
<  fb fc 80 fc a0 0f 84 a6 3c 80 fc 4f 0f 84 c0 2d
<  1e 06 57 56 55 52 51 53 50 50 8a c4 32 e4 d1 e0
< (II) stack at 0x00001ffa:
<  00 06 00 00 00 32
< (II) ATI(0): VESA BIOS not detected
---
> (II) ATI(0): VESA BIOS detected
> (II) ATI(0): VESA VBE Version 2.0
> (II) ATI(0): VESA VBE Total Mem: 4096 kB
> (II) ATI(0): VESA VBE OEM: ATI MACH64
> (II) ATI(0): VESA VBE OEM Software Rev: 1.0
> (II) ATI(0): VESA VBE OEM Vendor: ATI Technologies Inc.
> (II) ATI(0): VESA VBE OEM Product: MACH64GT
> (II) ATI(0): VESA VBE OEM Product Rev: 01.00
> (II) ATI(0): VESA VBE DDC supported
> (II) ATI(0): VESA VBE DDC Level 2
> (II) ATI(0): VESA VBE DDC transfer in appr. 2 sec.
> (II) ATI(0): VESA VBE DDC read successfully
> (II) ATI(0): Manufacturer: CPQ  Model: 3025  Serial#: 5797
> (II) ATI(0): Year: 1999  Week: 51
> (II) ATI(0): EDID Version: 1.1
> (II) ATI(0): Analog Display Input,  Input Voltage Level: 0.700/0.700 V
> (II) ATI(0): Sync:  Separate
> (II) ATI(0): Max H-Image Size [cm]: horiz.: 29  vert.: 22
> (II) ATI(0): Gamma: 2.88
> (II) ATI(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
> (II) ATI(0): redX: 0.625 redY: 0.340   greenX: 0.310 greenY: 0.592
> (II) ATI(0): blueX: 0.150 blueY: 0.063   whiteX: 0.281 whiteY: 0.311
> (II) ATI(0): Supported VESA Video Modes:
> (II) ATI(0): 720x400@70Hz
> (II) ATI(0): 720x400@88Hz
> (II) ATI(0): 640x480@60Hz
> (II) ATI(0): 640x480@67Hz
> (II) ATI(0): 640x480@72Hz
> (II) ATI(0): 640x480@75Hz
> (II) ATI(0): 800x600@56Hz
> (II) ATI(0): 800x600@60Hz
> (II) ATI(0): 800x600@72Hz
> (II) ATI(0): 800x600@75Hz
> (II) ATI(0): 832x624@75Hz
> (II) ATI(0): 1024x768@87Hz (interlaced)
> (II) ATI(0): 1024x768@60Hz
> (II) ATI(0): Manufacturer's mask: 0
> (II) ATI(0): Supported Future Video Modes:
> (II) ATI(0): #0: hsize: 640  vsize 480  refresh: 70  vid: 18993
> (II) ATI(0): #1: hsize: 640  vsize 480  refresh: 85  vid: 22833
> (II) ATI(0): #2: hsize: 800  vsize 600  refresh: 85  vid: 22853
> (II) ATI(0): Supported additional Video Mode:
> (II) ATI(0): clock: 25.2 MHz   Image Size:  262 x 196 mm
> (II) ATI(0): h_active: 640  h_sync: 656  h_sync_end 752 h_blank_end 800
h_border: 0
> (II) ATI(0): v_active: 350  v_sync: 387  v_sync_end 389 v_blanking: 449
v_border: 0
> (II) ATI(0): Supported additional Video Mode:
> (II) ATI(0): clock: 36.0 MHz   Image Size:  262 x 196 mm
> (II) ATI(0): h_active: 640  h_sync: 696  h_sync_end 747 h_blank_end 832
h_border: 0
> (II) ATI(0): v_active: 480  v_sync: 481  v_sync_end 484 v_blanking: 509
v_border: 0
> (II) ATI(0): Supported additional Video Mode:
> (II) ATI(0): clock: 56.2 MHz   Image Size:  262 x 196 mm
> (II) ATI(0): h_active: 800  h_sync: 832  h_sync_end 896 h_blank_end 1048
h_border: 0
> (II) ATI(0): v_active: 600  v_sync: 601  v_sync_end 604 v_blanking: 631
v_border: 0
> (II) ATI(0): Supported additional Video Mode:
> (II) ATI(0): clock: 56.2 MHz   Image Size:  262 x 196 mm
> (II) ATI(0): h_active: 800  h_sync: 832  h_sync_end 896 h_blank_end 1048
h_border: 0
> (II) ATI(0): v_active: 600  v_sync: 601  v_sync_end 604 v_blanking: 631
v_border: 0
368a415
> (WW) ATI(0): config file vrefresh range 60-85.06Hz not within DDC vrefresh
ranges.
485c532,533
< (==) ATI(0): DPI set to (75, 75)
---
> (--) ATI(0): Display dimensions: (290, 220) mm
> (--) ATI(0): DPI set to (89, 88)

... "Tiny, how do you spell farm?"  "You are really dumb, Bubba. E-I-E-I-O."
--- MultiMail/Linux v0.47
