Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270202AbUJTLvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270202AbUJTLvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270077AbUJTLsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:48:25 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:3028 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S267648AbUJTLoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:44:38 -0400
Message-ID: <4176537A.6070301@rgadsdon2.giointernet.co.uk>
Date: Wed, 20 Oct 2004 13:00:58 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8a2) Gecko/20040604
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-bk3 - compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

..............
GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xb8658): In function `i2o_pci_interrupt':
: undefined reference to `i2o_msg_out_to_virt'
drivers/built-in.o(.text+0xb8efa): In function `i2o_exec_reply':
: undefined reference to `i2o_msg_in_to_virt'
make: *** [.tmp_vmlinux1] Error 1

(GCC version 3.4.1)

Robert Gadsdon

...........
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

...........
#
# I2O device support
#
CONFIG_I2O=y
# CONFIG_I2O_CONFIG is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

........

