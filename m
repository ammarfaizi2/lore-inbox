Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUESDv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUESDv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 23:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUESDv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 23:51:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263784AbUESDv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 23:51:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_piix: port disabled.  ignoring.
Date: Tue, 18 May 2004 15:20:54 +0200
User-Agent: KMail/1.5.3
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be> <Pine.GSO.4.58.0405171308580.19405@waterleaf.sonytel.be> <Pine.GSO.4.58.0405171545490.19405@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0405171545490.19405@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405181520.54952.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 of May 2004 16:19, Geert Uytterhoeven wrote:

> If I disable CONFIG_SCSI_SATA, IDE works, but very slow (no DMA).

due to CONFIG_BLK_DEV_PIIX=n but ata_piix.c is prefferred for SATA

