Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311163AbSCHVvT>; Fri, 8 Mar 2002 16:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311159AbSCHVvJ>; Fri, 8 Mar 2002 16:51:09 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14466 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311151AbSCHVuz>; Fri, 8 Mar 2002 16:50:55 -0500
Date: Fri, 8 Mar 2002 22:38:12 +0100
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.6: undefined reference to `idescsi_init'
Message-ID: <20020308213812.GB13672@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following undefined referenced is encountered when linking the kernel.

drivers/ide/idedriver.o: In function 'ata_module_init':
drivers/ide/idedriver.o(.text.init+0x941): undefined reference to
descsi_init'

I suppose there is some easy way to solve this?!

Thanks,

Axel

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y

