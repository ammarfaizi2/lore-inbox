Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266323AbUFQBIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266323AbUFQBIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUFQBIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:08:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47041 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266323AbUFQBIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:08:19 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Andrew Chew" <achew@nvidia.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Thu, 17 Jun 2004 03:12:42 +0200
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406170312.42324.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is there any reason why this driver doesn't support
CK804-SATA[2] and  MCP04-SATA[2]?

Removing IDs from amd74xx.c is a bad idea,
it breaks boot on systems already using these IDs.

Cheers.

On Thursday 17 of June 2004 02:17, Andrew Chew wrote:
> This patch adds the file linux-2.6.7/drivers/scsi/sata_nv.c, updates
> linux-2.6.7/drivers/scsi/Makefile and linux-2.6.7/drivers/scsi/Kconfig
> to include the new driver, and removes
> PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
> and PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2 device IDs from the
> linux-2.6.7/drivers/ide/pci/amd74xx.c driver (these IDs will now be in
> the sata_nv.c driver).
>
> This patch is to be applied to the linux-2.6.7 kernel.
>
> Attaching patch file, as the patch is kind of large.

