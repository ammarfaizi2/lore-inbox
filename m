Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268895AbTCCXYZ>; Mon, 3 Mar 2003 18:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbTCCXYY>; Mon, 3 Mar 2003 18:24:24 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:19600 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268895AbTCCXYS>;
	Mon, 3 Mar 2003 18:24:18 -0500
Date: Tue, 4 Mar 2003 00:34:41 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303032334.h23NYf6X012570@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.63: Can't handle class_mask in drivers/serial/8250_pci
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.5.63 with PCI enabled and SERIAL_8250 as a module
generates these warnings from scripts/file2alias:do_pci_entry(),
via scripts/modpost:

*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0001
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0002
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0004
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:0008
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00
*** Warning: Can't handle class_mask in drivers/serial/8250_pci:FFFF00

Non-fatal, but something's obviously not right.

Who maintains drivers/serial/, Theodore Ts'o or Russell King?

/Mikael
