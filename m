Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275324AbTHGNhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275330AbTHGNhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:37:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9128 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275324AbTHGNgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:36:48 -0400
Date: Thu, 7 Aug 2003 15:35:54 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <casino_e@terra.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to 2.6.0-test2
In-Reply-To: <1060259371.3169.41.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0308071535110.20585-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Aug 2003, Alan Cox wrote:

> On Iau, 2003-08-07 at 10:49, CASINO_E wrote:
> > > We never check the cable bits for SATA so this is a no-op
> >
> > Alan,
> >
> > Without this, in 2.4.22-pre10-ac1, ide_ata66_check() in ide-iops.c
> > returns 1. This causes, for example, that hdparm -i shows only udma
> > modes 0 to 2 (although the drive has been set to udma6) and refuses to
> > set any value above udma2 with an ugly "Speed warnings UDMA 3/4/5 is
> > not functional".
>
> Then the bug is that ide_ata66_check is getting called at all in the
> SATA controller case

drive->sata ?

