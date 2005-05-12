Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVELVQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVELVQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVELVQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:16:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43400 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262123AbVELVQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:16:16 -0400
Date: Thu, 12 May 2005 11:24:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.31-pre2
Message-ID: <20050512142413.GC18703@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes 2.4.31-pre2.

It contains a small number of changes, most notably 
the elf_core_dump flaw fix (CAN-2005-1263).

Please refer to -hf tree for the standalone patch.

http://linux.exosec.net/kernel/2.4-hf/


Summary of changes from v2.4.31-pre1 to v2.4.31-pre2
============================================

<carlos.pardo:siliconimage.com>:
  o sata_sil: Fix FIFO PCI Bus Arbitration

<david.monniaux:ens.fr>:
  o fix moxa crash with more than one 1 board

<jason.d.gaston:intel.com>:
  o SATA AHCI correction Intel ICH7R

Brett Russ:
  o AHCI: fix fatal error int handling
  o libata: support descriptor sense in ctrl page

Chris Wright:
  o backport v2.6 elf_core_dump() flaw fix (CAN-2005-1263)

Eugene Surovegin:
  o ppc32: backport Book-E decrementer handling fix from 2.6

Jean Delvare:
  o I2C updates: Fix typo in a comment in i2c.h
  o I2C updates: Fix I2C_FUNC_* defines in i2c.h
  o I2C updates: Fix an iteration bug in the handling of i2c client module parameters

Jeff Garzik:
  o [libata ahci] support ->tf_read hook
  o [libata sata_sil] Don't presume PCI cache-line-size reg is > 0

Marcelo Tosatti:
  o Change EXTRAVERSION to 2.4.31-pre2

Mikael Pettersson:
  o rwsem-spinlock linkage error

Pete Zaitcev:
  o USB: Add HX type pl2303

Rolf Eike Beer:
  o typo fix in drivers/scsi/sata_svw.c comment

Steven HARDY:
  o pcnet32: 79C975 fiber fix

Willy Tarreau:
  o bonding fix

