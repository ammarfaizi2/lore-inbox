Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUFSXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUFSXFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFSXFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:05:41 -0400
Received: from port760.ds1-suoe.adsl.cybercity.dk ([212.242.163.7]:11610 "EHLO
	mha.dyndns.dk") by vger.kernel.org with ESMTP id S264503AbUFSXFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:05:34 -0400
Subject: Re: Corruption and crashes with SIL3112A SATA chipset
From: Martin Alexander Hammer <mha@mha.dyndns.dk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D4A5AB.9060105@pobox.com>
References: <1087668387.1972.72.camel@idoru>  <40D4A5AB.9060105@pobox.com>
Content-Type: text/plain
Message-Id: <1087686333.4673.14.camel@idoru>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 20 Jun 2004 01:05:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 22:44, Jeff Garzik wrote:
> Does it help to add the Seagate disk model number to the blacklist in 
> sata_sil.c?

Well, I added the model number (ST3200822AS) to the blacklist, and now
the controller doesn't see the disks anymore:

libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xD280F080 ctl 0xD280F08A bmdma 0xD280F000 irq 18
ata2: SATA max UDMA/100 cmd 0xD280F0C0 ctl 0xD280F0CA bmdma 0xD280F008 irq 18
ata1: no device found (phy stat 00000000)
scsi1 : sata_sil
ata2: no device found (phy stat 00000000)
scsi2 : sata_sil

-- 
Med venlig hilsen

Martin Alexander Hammer
http://mha.dyndns.dk

