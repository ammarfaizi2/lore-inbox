Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVDAJBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDAJBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDAJBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:01:23 -0500
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:55501 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261657AbVDAJBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:01:20 -0500
Date: Fri, 01 Apr 2005 11:01:17 +0200 (CEST)
From: Helmut Jarausch <jarausch@igpm.rwth-aachen.de>
Subject: Adaptec kernel panic (2.6.12-rc1-bk3)
To: linux-kernel@vger.kernel.org
Cc: jarausch@igpm.rwth-aachen.de
Reply-to: jarausch@igpm.rwth-aachen.de
Message-id: <20050401090117.7E6C8DAD64@numa-i.igpm.rwth-aachen.de>
MIME-version: 1.0
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please help!!!

I have a 4 years old SuperMicro server (dual P3) with an
Adaptec I2O raid controler.

This server is running just fine with 2.4.28-pre3.
Now I've tried to run it under 2.6.12-rc1-bk3 (and -bk1)
First the system seems to boot normally, but then I get a

kernel panic - not syncing: Fatal exception in interrupt
EIP is at adpt_isr+0x131/0x230
in process swapper.

The same kernel is running just fine on a twin machine but
which doesn't have an adaptec raid controler.

The Adaptec controler shows up as

Adaptec I2O BIOS v 001.3W  2001/05/10

I've configured
CONFIG_SCSI_DPT_I2O=y
CONFIG_I2O=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y


Many thanks for any hints.
Should I upgrade the Adaptec BIOS though I'm a bit afraid of that.


Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
RWTH - Aachen University
D 52056 Aachen, Germany

