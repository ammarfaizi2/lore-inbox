Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbUDONjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263908AbUDONjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:39:15 -0400
Received: from moo.samara.net ([195.209.64.5]:50437 "EHLO moo.samara.net")
	by vger.kernel.org with ESMTP id S263892AbUDONjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:39:08 -0400
Subject: Promise SX-6000 and Kernel 2.6.5
From: Alex Murphy <murphy@sgtp.samara.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SYS.NET.RU
Message-Id: <1082036339.4960.63.camel@bene.samgtp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 18:38:59 +0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!!!

 I am sorry for the letter, but already some weeks testing with subject.
Has established Promise SX-6000 RAID. Has compiled an original nucleus
2.6.5_rc2.

 In make menuconfig has disconnected support of all PDC Promise. Has
included all I2O devices in a nucleus.

ns linux # cat .config|grep I2O
# I2O device support
CONFIG_I2O=y
CONFIG_I2O_PCI=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y


dmesg send 0 i2o controllers

I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 17
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ f7ae85a0
  (512 byte buffers X 4 can_queue X 0 i2o controllers)


lspci:

02:02.1 Class ff00: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02)
(prog-if 01)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
        Flags: bus master, medium devsel, latency 32, IRQ 22
        Memory at f6000000 (32-bit, prefetchable) [size=4M]
        Expansion ROM at <unassigned> [disabled] [size=64K]


 I use devfs. Distribution kit Gentoo. Long searched on the Internet,
but and I can not start raid.

Prompt where still to look please.

Yours faithfully, Alexey.

