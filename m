Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTBLNvp>; Wed, 12 Feb 2003 08:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTBLNvo>; Wed, 12 Feb 2003 08:51:44 -0500
Received: from Thales.MI.Uni-Koeln.DE ([134.95.213.2]:9973 "EHLO
	Thales.MI.Uni-Koeln.DE") by vger.kernel.org with ESMTP
	id <S267242AbTBLNu7>; Wed, 12 Feb 2003 08:50:59 -0500
Date: Wed, 12 Feb 2003 15:00:47 +0100 (MET)
From: Klaus Niederkrueger <kniederk@MI.Uni-Koeln.DE>
X-X-Sender: kniederk@Thales
To: linux-kernel@vger.kernel.org
Subject: 760MPX freezes with ohci-module
Message-ID: <Pine.GSO.4.44.0302121448400.23758-100000@Thales>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm wondering what is wrong with my system: It is an ASUS-M266D,
(760MPX-chipset, 768 Northbridge, 762 southbridge) that comes with a USB
2.0-NEC card, but it has an USB 1.1 onboard controller. I'm using a single
AthlonXP processor.

The distribution I'm using is SuSE 8.0, but I have installed the Marcelo
2.4.20 kernel and later the Marcelo 2.4.21-pre4 kernel with no success.

As soon as I load the ohci-module for the onboard controller the system
freezes.  (there was in an earlier versions a hw-bug in the chipset, but
as far as I know my chipset has a newer revision, where this has been
fixed). This also happens, if I unload first the Ehci-module for the
USB2.0-card.

I also tried Knoppix 3.1 and it only boots, if I switch off the
usb-probing on the boot-prompt, otherwise it also freezes.

If I load the standard kernel that comes with the Suse-distribution 8.0
the usb-port works. What is wrong? If you need further information please
ask.

I looked at the log-files, but did not find any message related to the
crash.

I'm not on the mailing list, so if you have any hint, please CC also to
me.

Thanks a lot.

	Klaus

