Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRKYIdK>; Sun, 25 Nov 2001 03:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280757AbRKYIdA>; Sun, 25 Nov 2001 03:33:00 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:39314 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276894AbRKYIcx>; Sun, 25 Nov 2001 03:32:53 -0500
Subject: eepro100 Driver Problems ( wait
From: Sid Carter <sidcarter@symonds.net>
URL: http://www.symonds.net/~sidcarter/
Operating-System: Turing OS XCVII
Disclaimer: Not speaking for anyone in any way, shape, or form.
Copyright: Copyright 2001 Sid Carter - All Rights Reserved
To: linux-kernel@vger.kernel.org
Reply-To: sidcarter@symonds.net
Organization: Sid Carter Inc.
Date: 25 Nov 2001 14:01:37 +0530
Message-ID: <87zo5bgsk6.fsf@toboggan.in.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I recently got a new comp. It's an IBM PC with an Intel Motherboard.

The results of lspci:

toboggan:~# lspci
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev 02)
00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller (rev 02)
01:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller (rev 01)

I have setup it for network. It is running the Default Linus' 2.4.14 kernel
tree with the SGI's XFS Patch. 

toboggan:~# uname -a
Linux toboggan 2.4.14-xfs.hommade #1 Sun Nov 11 00:01:40 IST 2001 i686 unknown

Nov 25 13:43:58 toboggan kernel: eepro100: wait_for_cmd_done timeout!
Nov 25 13:44:13 toboggan last message repeated 5 times

I keep getting the above errors on my machine after which my network connection
goes. This keeps happening randomly. I have to do a restart of my network to get
on to the network. Anyone knows what the problem ? How I can fix it ?
Please let me know if you require further information for an analysis of the
problem.

Thanks in Advance
Regards
        Carter
-- 
The only difference between your girlfriend and a barracuda is the nailpolish.

Sid Carter                                                   Debian GNU/Linux.
