Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUC1LLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUC1LLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:11:30 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:58127 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261154AbUC1LL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:11:26 -0500
Message-ID: <4066B2FE.1020903@philrigby.com>
Date: Sun, 28 Mar 2004 12:11:58 +0100
From: Phil Rigby <phil@philrigby.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA: Bug?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...
Applied the patch to 2.6.5.rc-2, got these errors after recompile/reboot 
(from dmesg):-

VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
libata: Unknown symbol pci_dma_mapping_error
sata_sil: Unknown symbol ata_std_bios_param
sata_sil: Unknown symbol ata_tf_load_mmio
sata_sil: Unknown symbol ata_bmdma_start_mmio
sata_sil: Unknown symbol ata_tf_read_mmio
sata_sil: Unknown symbol ata_exec_command_mmio
sata_sil: Unknown symbol sata_phy_reset
sata_sil: Unknown symbol ata_check_status_mmio
sata_sil: Unknown symbol ata_interrupt
sata_sil: Unknown symbol ata_scsi_slave_config
sata_sil: Unknown symbol ata_fill_sg
sata_sil: Unknown symbol ata_std_ports
sata_sil: Unknown symbol ata_scsi_error
sata_sil: Unknown symbol ata_port_disable
sata_sil: Unknown symbol ata_scsi_queuecmd
sata_sil: Unknown symbol ata_eng_timeout
sata_sil: Unknown symbol ata_port_stop
sata_sil: Unknown symbol ata_pci_remove_one
sata_sil: Unknown symbol ata_device_add
sata_sil: Unknown symbol ata_port_start

Any ideas?  This is an Asus A7N8V Deluxe mobo, NForce2 chipset and a 
Maxtor SATA disc (Model=ST3120026AS).  I have the SIS 3112 ATA chipset 
(compiled in ATA support) and Silicon Image SATA support compiled in 
SCSI low level drivers.

I can post any more information you want.

Phil.
