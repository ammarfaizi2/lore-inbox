Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVIRTwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVIRTwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 15:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVIRTwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 15:52:38 -0400
Received: from xenotime.net ([66.160.160.81]:27280 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932181AbVIRTwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 15:52:38 -0400
Date: Sun, 18 Sep 2005 12:52:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Christian Fischer <Christian.Fischer@fischundfischer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86: mounting scsi-cdrom: kernel panic with vanilla and others,
 works with ac
Message-Id: <20050918125232.3e53ced9.rdunlap@xenotime.net>
In-Reply-To: <200509181557.37934.Christian.Fischer@fischundfischer.com>
References: <200509181557.37934.Christian.Fischer@fischundfischer.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005 15:57:37 +0200 Christian Fischer wrote:

> Hi all.
> 
> Some days ago I've tried 2.6.12-cko3 and got "Kernel panic - not syncing: 
> Fatal exception in interrupt" by mounting the cdrom (scsi). Known problem I 
> thought, I had this if I tried to switch from 2.6.11-ac7 to 2.6.11-gentoo. 

Need kernel message log, please.

> To point out if this is a problem of gentoo-base patches or cko-patches i 
> tried 2.6.12-vanilla and got Kernel panic.

How about 2.6.14-rc1 ?

> Mainboard: SuperMicro MBD-P4SCT-0
> Chipset: Intel 875
> CPU: Intel P4 2,4 
> Memory: ECC
> SCSI: Tekram TRM-S1040
> 
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_X86_UP_APIC is not set
> 
> CONFIG_SCSI=y
> CONFIG_SCSI_PROC_FS=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_SATA=y
> CONFIG_SCSI_ATA_PIIX=y
> CONFIG_SCSI_SYM53C8XX_2=m
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> CONFIG_SCSI_QLA2XXX=y
> CONFIG_SCSI_DC395x=y
> CONFIG_SCSI_DC390T=y


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
