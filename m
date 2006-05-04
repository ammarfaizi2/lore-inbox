Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWEDPU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWEDPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEDPU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:20:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751489AbWEDPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:20:26 -0400
Subject: RE: Generic SATA driver which works with Marvell SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
Cc: "'Erik Mouw'" <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAo6BlOIGRPESYDOrUYkqB1gEAAAAA@spsoftindia.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAo6BlOIGRPESYDOrUYkqB1gEAAAAA@spsoftindia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 May 2006 16:31:48 +0100
Message-Id: <1146756708.22308.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-04 at 19:33 +0530, Yogesh Pahilwan wrote:
> I believe there must be some low level driver for the SATA devices (eg:
> mv_sata for Marvel SATA) which allows sd_mod to expose them as a scsi
> devices?

sata_mv drives the marvell chipsets, you want 2.6.16/17-rc for this.
There is no such thing as a "generic" SATA driver as all SATA chipsets
have their own interfaces, unlike PATA where there was a basic standard.

A standard is emerging (called AHCI) and in time it may be that all SATA
uses the same driver just as we have few USB drivers.

