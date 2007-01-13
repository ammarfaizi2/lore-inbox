Return-Path: <linux-kernel-owner+w=401wt.eu-S1030523AbXAMMKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbXAMMKP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 07:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXAMMKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 07:10:15 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:47460 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030514AbXAMMKN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 07:10:13 -0500
From: Faik Uygur <faik@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci_softreset prevents acpi_power_off
Date: Sat, 13 Jan 2007 14:10:33 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
References: <200701111231.26819.faik@pardus.org.tr> <45A831EA.50601@gmail.com>
In-Reply-To: <45A831EA.50601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701131410.34265.faik@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

13 Oca 2007 Cts 03:12 tarihinde şunları yazmıştınız:
> If possible, please post dmesg of shutting down.  

I have taken more detailed dmesg outputs of three configs with ATA_DEBUG and 
ATA_VERBOSE_DEBUG defined. You can find them at this address:

http://cekirdek.pardus.org.tr/~faik/tmp/ahci/

* ahci file is the output of CONFIG_SCSI_SATA_AHCI compiled config
* noahci file is the output of CONFIG_SCSI_SATA_AHCI not compiled config
* ahci-nullsoftreset is the output of CONFIG_SCSI_SATA_AHCI compiled config
but given NULL to softreset parameters of ata_do_eh in ahci.c

Also poweroff-config is the used .config file. Only CONFIG_SCSI_SATA_AHCI is
changed between them.

I am not familiar with AHCI nor ATA internals. So please ask if you would like 
to see anything more.

Regards,
- Faik
