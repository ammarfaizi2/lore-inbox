Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVCTTs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVCTTs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVCTTs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:48:58 -0500
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:38674 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261253AbVCTTsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:48:36 -0500
Message-ID: <423DD38E.7000409@roarinelk.homelinux.net>
Date: Sun, 20 Mar 2005 20:48:30 +0100
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guido Villa <piribillo@yahoo.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Error with Sil3112A SATA controller and Maxtor 300GB HDD
References: <20050312160704.22527.qmail@gg.mine.nu>            <4233254F.3000509@roarinelk.homelinux.net> <20050316184523.30672.qmail@gg.mine.nu>
In-Reply-To: <20050316184523.30672.qmail@gg.mine.nu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Guido Villa wrote:

>>I happen to have a SiI 3112A controller and a Maxtor 6B300S0 attached to
>>it, formatted with ext2. Never had any problems. I just copied
>>200GB of data to it, worked flawlessly. (Vanilla 2.6.11)
>>Maybe its the Motherboard?

> I was checking my kernel configuration, and some doubts arised in my mind. 
> Would you please check if my parameters are the same as yours? 
> 
> set:
> CONFIG_IDE_GENERIC
> CONFIG_BLK_DEV_IDEPCI
> CONFIG_SCSI
> CONFIG_BLK_DEV_SD
> CONFIG_SCSI_SATA
> CONFIG_SCSI_SATA_SIL 
> 
> unset:
> CONFIG_BLK_DEV_GENERIC
> CONFIG_BLK_DEV_SIIMAGE (I'm unsure on this) 

Heres a snippet from the box's .config:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_SIL=y

This is for Piix4 + promise20268 IDE
and the Sil sata ctrl, only harddisks.

-- 
  Manuel Lauss
