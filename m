Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbRFBJo2>; Sat, 2 Jun 2001 05:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262407AbRFBJoR>; Sat, 2 Jun 2001 05:44:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44475 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262406AbRFBJoJ>;
	Sat, 2 Jun 2001 05:44:09 -0400
Date: Sat, 2 Jun 2001 11:44:07 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106020944.LAA115638.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Makefile/Config flaw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.4.5 with CONFIG_USB=y and CONFIG_PCI not set
fails with drivers/usb/usbdrv.o: undefined reference to `pci_pool_*'.
