Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUAFM4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUAFM4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:56:36 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:4994 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261973AbUAFM4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:56:35 -0500
Date: Tue, 6 Jan 2004 13:56:34 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: won't work: 2.6.0 && SiI 3112 SATA
Message-ID: <20040106135634.A5825@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I try to make Adaptec SATA RAID AAR-1210SA (in fact, SiI 3112 ACT 144 chip)
work under 2.6.0

When booting, get "hde: lost interrupt" and DMA errors. Tried to switch
on/off local and I/O APIC (singleproc board) and the errors stay the same.

Are these errors experienced on all SiI3112 boards? Are they experienced
also in 2.4 kernel? Shall I try some "newer" kernel than 2.6.0?

What's the difference between SiI3112 and SiI 3114? I found a note about
adding some SiI 3114 patch in the 2.6 -mm kernel but don't know if it's
relevant for me.

Have downloaded the SiI 3112 datasheet but they don't say much about how the
registers are configured etc. - just how serial EEPROM is connected
(yes, there's an AM29LV0108-903C by AMD on the board) and what SATA commands
are supported.

Is the programming interface of the chip proprietary or is it covered in
SATA, ATA or even PCI spec.?

Cl<
