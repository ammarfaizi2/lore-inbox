Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310441AbSCWRQA>; Sat, 23 Mar 2002 12:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310488AbSCWRPv>; Sat, 23 Mar 2002 12:15:51 -0500
Received: from mustard.heime.net ([194.234.65.222]:53145 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S310441AbSCWRPk>; Sat, 23 Mar 2002 12:15:40 -0500
Date: Sat, 23 Mar 2002 18:15:36 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] USB keyboard reboots kernel upon startup
Message-ID: <Pine.LNX.4.30.0203231727330.9887-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

When booting up with a Logitech USB keyboard (the one with a with scroll
wheel), the system reboots immediately when probing for an AT keyboard
(after pty: 256 Unix98 ptys configured). When unplugging it, I get this

keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)

any ideas?

it works fine if I re-attach the keyboard after reboot

I'm using kernel 2.4.19-pre3-ac1

PCI controller is an SiS

  Bus  0, device   1, function  2:
    USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 7).
      IRQ 12.
      Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe7800000 [0xe7800fff].
  Bus  0, device   1, function  3:
    USB Controller: Silicon Integrated Systems [SiS] 7001 (#2) (rev 7).
      IRQ 12.
      Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe7000000 [0xe7000fff].

thanks

roy

--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.


