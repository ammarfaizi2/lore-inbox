Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbTCMOyo>; Thu, 13 Mar 2003 09:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbTCMOyo>; Thu, 13 Mar 2003 09:54:44 -0500
Received: from 80-26-6-149.uc.nombres.ttd.es ([80.26.6.149]:49424 "EHLO
	bonkers.sytes.net") by vger.kernel.org with ESMTP
	id <S261298AbTCMOyn>; Thu, 13 Mar 2003 09:54:43 -0500
Subject: CRC errors decompressing kernel on boot
From: Pedro Soria Rodriguez <psoria@hispafuentes.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Organization: HispaFuentes
Message-Id: <1047567911.3419.17.camel@queen.pelusa.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-2mdk 
Date: 13 Mar 2003 16:05:11 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am getting a CRC error when the kernel is being decompressed after
loading.  It is intermitent, but I can force it to occur on every boot
if I type on the keyboard while the kernel is loaded (before being 
decompressed). 

It happens on a certain machine, with USB keyboard.
It does *not* happen with a PS2 keyboard.
It does not happen on other machines with USB or PS2 keyboards.

I would say this is a hardware problem, as I see it happen only on a certain
type of machine.  It is custom built by a manufacturer in Spain, with:
# lspci
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 01)
00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated Graphics Device (rev 01)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)

The keyboard is USB.  Lilo is 22.4.
Problem happens both with 2.4.20-ac2 and 2.4.21-pre5-ac2
kernels are compiled with gcc (GCC) 3.2.3 20030221 (Debian prerelease)
and I saw no problems during compilation.

All i really need to know is whether it is a Linux problem, a Lilo problem
or a hardware problem.   Any help I can get will be helpful.
I searched the kernel list archives but found nothing similar to this
problem.

Thank you,

-- 
Pedro Soria Rodríguez
psoria@hispafuentes.com

