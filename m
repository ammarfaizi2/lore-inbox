Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKPBYn>; Wed, 15 Nov 2000 20:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPBYd>; Wed, 15 Nov 2000 20:24:33 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:25782 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129187AbQKPBYW>; Wed, 15 Nov 2000 20:24:22 -0500
From: dep <dennispowell@earthlink.net>
To: "Karnik, Rahul" <rakarnik@davidson.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: VIA IDE bug with WD drive?
Date: Wed, 15 Nov 2000 19:56:43 -0500
X-Mailer: KMail [version 1.2]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1DE3DA661DC2D31190030090273D1E6A0153FA97@pobox.davidson.edu>
In-Reply-To: <1DE3DA661DC2D31190030090273D1E6A0153FA97@pobox.davidson.edu>
MIME-Version: 1.0
Message-Id: <00111519564300.04831@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2000 19:30, Karnik, Rahul wrote:

| I get the following error if I try to enable DMA on my Abit KT7
| motherboard with a VIA2C686 chipset:
|
| hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest
| } hdb: timeout waiting for DMA
| hda: DMA disabled
| hdb: DMA disabled
| ide0: reset: success

i get the same thing, along with a crc error, over and over on a 
20-gig WD IDE drive. alternately puzzling and frightening. 
apparently, wd uses some nonstandard goofball error checking thing 
that just doesn't work with linux at present. it *seems* to do no 
harm.
-- 
dep
--
Everyone is entitled to his own opinion but not his own facts.
                                    -- Daniel Patrick Moynahan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
