Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVK3JNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVK3JNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 04:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVK3JNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 04:13:19 -0500
Received: from mail0.rawbw.com ([198.144.192.41]:30483 "EHLO mail0.rawbw.com")
	by vger.kernel.org with ESMTP id S1751156AbVK3JNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 04:13:19 -0500
Date: Wed, 30 Nov 2005 01:13:12 -0800
To: linux-kernel@vger.kernel.org
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>
Subject: WD 2nd generation SATA not detected on Intel 945PSNLK
Message-ID: <20051130091312.GC4092@wheat.betterworld.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Ross Boylan <RossBoylan@stanfordalumni.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an excessively new system for which 2.6.12 kernel in the Debian
etch beta 1 installer doesn't detect the hard drive.
Intel D945PSNLK Motherboard
WD25000JS-OOM, which Western Digital's site says is a 2nd generation
SATA.
Pentium 4 630 processor.

Intel provides drivers for this motherboard, but they only seem to
concern the on-board audio and LAN.  I'm not sure if the problem is
the m/b or the disk, or the combination.  Win2K managed to see the
drive, so the hardware is OK.

dmesg shows IHC7:
ICH7: IDE controller at PCI slot 0000:00:1f.1
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
  ide0: BM-DMA at 0x30b0-0x30b7, BIOST settings: hda:DMA, hdb:pio
Unfortunately, the thing at IDE0 is the DVD.

manually loading the ahci driver doesn't work.  An earlier thread with
a somewhat similar problem advised doing this to see what the messages
were, but nothing useful showed up (modprove -v ahci).

The installer doesn't seem to have lspci.

I've tried ATA/IDE mode as enhanced and legacy in the BIOS; neither
works.

Any suggestions?

I would appreciate if you cc'd me.
Thanks.
