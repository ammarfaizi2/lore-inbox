Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbUBBROJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUBBROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:14:08 -0500
Received: from defout.telus.net ([199.185.220.240]:17832 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S265713AbUBBRNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:13:45 -0500
Subject: DMA timeout on 2.6.2-rc3
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1075742046.3670.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 02 Feb 2004 10:14:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have lately had an error that will stall the boot process.  I
have a bad feeling that it might be hardware, but need just a bit more
information.  The error I get is:
hda: dma_timer_expiry: dma status == 0x60
hda: DMA timeout retry
hda: timeout waiting for DMA

My distro: Fedora Core 1
Kernel version: 2.6.2-rc3-bk1
My APIC has integrated dma controllers and is a SiS 961
lspci also reports:
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS961 [MuTIOL
Media IO]
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016

I looked in /documentation and grepped some of the kernel source for dma
status, but haven't found a dma status of 0x60 (other statuses, but not
0x60 or 96).  TIA

Bob

