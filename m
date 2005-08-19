Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVHSLqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVHSLqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVHSLqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:46:20 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:36421 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932644AbVHSLqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:46:19 -0400
Message-ID: <4305C5AA.20200@emc.com>
Date: Fri, 19 Aug 2005 07:42:34 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [git] libata-dev queue updated
References: <20050819035437.GA18324@havoc.gtf.org>
In-Reply-To: <20050819035437.GA18324@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.8.19.6
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ -0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>In such cases, patches are divided into branches by category: ncq (NCQ
>queueing support), chs-support (C/H/S support), adma (new ADMA driver),
>sil24 (new Silicon Image 312x driver), passthru (ATA passthrough/SMART
>support), etc.
>  
>
Jeff,
The below doesn't seem to include NCQ. Is this an oversight?
Thanks,
BR

>Albert Lee:
>  [libata] C/H/S support, for older devices
>  [libata] add driver for Promise PATA 2027x
>  libata-dev-2.6: pdc2027x add ata_scsi_ioctl
>  libata-dev-2.6: pdc2027x change comments
>  libata-dev-2.6: pdc2027x move the PLL counter reading code
>  libata-dev-2.6: pdc2027x PLL input clock detection fix
>  libata ata_data_xfer() fix
>  libata handle the case when device returns/needs extra data
>  libata-dev: Convert pdc2027x from PIO to MMIO
>  libata-dev: pdc2027x use "long" for counter data type
>  libata-dev: pdc2027x ATAPI DMA lost irq problem workaround
>
>Daniel Drake:
>  sata_nv: Support MCP51/MCP55 device IDs
>
>Douglas Gilbert:
>  [libata scsi] add START STOP UNIT translation
>
>Erik Benada:
>  [libata sata_promise] support PATA ports on SATA controllers
>
>Jason Gaston:
>  ahci: AHCI mode SATA patch for Intel ICH7-M DH
>
>Jeff Garzik:
>  [libata] add new driver ata_adma
>  [libata adma] enable PCI MWI during controller initialization
>  [libata] ATA passthru (arbitrary ATA command execution)
>  [libata] ata_adma: update for recent ->host_stop() API changes
>  [libata] pata_pdc2027x: update for recent ->host_stop() API changes
>  libata: Update 'passthru' branch for latest libata
>  libata: trim trailing whitespace.
>
>Tejun Heo:
>  SATA: rewritten sil24 driver
>  sil24: add FIXME comment above ata_device_add
>  sil24: remove irq disable code on spurious interrupt
>  sil24: add testing for PCI fault
>  sil24: move error handling out of hot interrupt path
>  sil24: remove PORT_TF
>  sil24: replace pp->port w/ ap->ioaddr.cmd_addr
>  sil24: fix PORT_CTRL_STAT constants
>  sil24: add more comments for constants
>  
>
