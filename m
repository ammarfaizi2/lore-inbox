Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUFTChj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUFTChj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 22:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUFTChj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 22:37:39 -0400
Received: from nome.ca ([65.61.200.81]:32980 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S264541AbUFTChi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 22:37:38 -0400
Date: Sun, 20 Jun 2004 11:38:36 +0900
From: kernel@mikebell.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
Message-ID: <20040620023833.GN497@tinyvaio.nome.ca>
References: <Pine.GSO.4.33.0406181831180.25702-100000@sweetums.bluetronic.net> <200406192210.05455.rjwysocki@sisk.pl> <40D49FBC.7040900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D49FBC.7040900@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 04:19:08PM -0400, Jeff Garzik wrote:
> I wonder if it helps to add the Seagate drive to the sata_sil blacklist?

To confirm, I also see the problem despite adding the drives to
the blacklist on 2.6.7.

sata_sil version 0.54

ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata2(0): applying Seagate errata fix
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil

Vendor: ATA       Model: ST3120026AS       Rev: 3.18
Vendor: ATA       Model: ST3120026AS       Rev: 3.18
