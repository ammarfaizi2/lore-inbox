Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQKPBBV>; Wed, 15 Nov 2000 20:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQKPBBL>; Wed, 15 Nov 2000 20:01:11 -0500
Received: from elvis.davidson.edu ([152.42.62.1]:47630 "EHLO
	elvis.davidson.edu") by vger.kernel.org with ESMTP
	id <S129371AbQKPBBJ>; Wed, 15 Nov 2000 20:01:09 -0500
Message-ID: <1DE3DA661DC2D31190030090273D1E6A0153FA97@pobox.davidson.edu>
From: "Karnik, Rahul" <rakarnik@davidson.edu>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: VIA IDE bug with WD drive?
Date: Wed, 15 Nov 2000 19:30:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I get the following error if I try to enable DMA on my Abit KT7 motherboard
with a VIA2C686 chipset:

hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: timeout waiting for DMA
hda: DMA disabled
hdb: DMA disabled
ide0: reset: success

hdb is a Western Digital 136BA 13,6 GB drive and hda is a Maxtor 20GB drive.
I do not get the error when enabling DMA on the Maxtor drive (hda).

I have tried kernel versions 2.2.16-3 (stock RH7), 2.2.17 and 2.4.0-testx.
Is this a known bug? Is it solved by the IDE backport patch?

TIA,
Rahul

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
