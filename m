Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVAUOIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVAUOIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVAUOIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:08:07 -0500
Received: from jagor.srce.hr ([161.53.2.130]:10680 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id S262365AbVAUOIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:08:01 -0500
Message-ID: <41F10CBC.5000307@spymac.com>
Date: Fri, 21 Jan 2005 15:07:56 +0100
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ps/2 mouse going crazy
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, i have this funny problem, googled around a bit, and found a same 
problem here, on the list, several days ago:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110579505706542&w=2
so, just to inform you, guy is not imagining things, problem exists and 
is quite annoying. happends every 2-3 hours?!

# dmesg | grep -i mouse
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
psmouse.c: bad data from KBC - bad parity
psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 3 bytes away.

mouse is MS-600, a relatively cheap no name optical mouse. cable is OK.

my lspci output:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
00:0b.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0c.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 61)
00:0c.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 61)
00:0c.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If 
[Radeon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon RV250 [Radeon 
9000] (Secondary) (rev 01)

kernel version
Linux 2.6.10-as2 (same in ck4/5)

if i can help with more info, please post full instructions since i'm a 
semi-newbie :)
