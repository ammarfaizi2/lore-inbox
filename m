Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFQIdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTFQIdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:33:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18840 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261153AbTFQIdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:33:39 -0400
Date: Tue, 17 Jun 2003 10:47:11 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: CAMTP guest <camtp.guest@uni-mb.si>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: CMD680 missing from 2.4.21?
In-Reply-To: <16110.53504.547180.164358@proizd.camtp.uni-mb.si>
Message-ID: <Pine.SOL.4.30.0306171045190.13723-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jun 2003, CAMTP guest wrote:

> Was CMD680 support forgotten in 2.4.21 or am I missing
> something? In 2.4.19 and .20 I get:
>
> CMD680: IDE controller on PCI bus 00 dev 58
> CMD680: chipset revision 1
> CMD680: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
>
> in 2.4.21 it is not detected (same config). I have found

Sometimes config options change :-).
CONFIG_BLK_DEV_SIIMAGE=y

Regards,
--
Bartlomiej

