Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRKMUU4>; Tue, 13 Nov 2001 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278788AbRKMUUq>; Tue, 13 Nov 2001 15:20:46 -0500
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:31703 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S278808AbRKMUU3>; Tue, 13 Nov 2001 15:20:29 -0500
Message-ID: <3BF18144.D0DE0F35@uu.net>
Date: Tue, 13 Nov 2001 15:23:33 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: cyjamten@ihug.com.au, linux-kernel@vger.kernel.org
Subject: Re: AMD761Agpgart+Radeon64DDR+kernel+2.4.15-pre2...still testing....
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add Option "AGPMode" "4"  to the device section of your XF86Config file
to use 4x AGP.

Alex

------------------------------

hi all, 

My X server seems to be cooperating with me quite lately... I have tried 
a new XF86Config file which was patterned to the someone who sent his to 
me... Thanks for that!! anyway... for extra info here it is: 

root@matrix:~# lspci 
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e 
(rev 13) 
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f 
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40) 
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) 
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) 
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) 
00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 
[Apollo Super ACPI] (rev 40) 
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20) 
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 
(rev 05) 
00:0b.1 Input device controller: Creative Labs SB Live! (rev 05) 
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02) 
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02) 
01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5144 

part of glxinfo: 

iceman@matrix:~$ glxinfo 
name of display: :0.0 
display: :0 screen: 0 
direct rendering: Yes 
server glx vendor string: SGI 
server glx version string: 1.2 
server glx extensions: 
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context 
client glx vendor string: SGI 
client glx version string: 1.2 
client glx extensions: 
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context 
GLX extensions: 
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context 
OpenGL vendor string: VA Linux Systems, Inc. 
OpenGL renderer string: Mesa DRI Radeon 20010402 AGP 1x x86/MMX/3DNow! 
OpenGL version string: 1.2 Mesa 3.4.2 

take note: Agp1x :( 

cheers!! 

cyrus
