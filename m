Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJ0J7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJ0J7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:59:09 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31185 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261384AbTJ0J7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:59:05 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Michel Bouissou <michel@bouissou.net>
Subject: Re: Patch for Promise PDC20276
Date: Mon, 27 Oct 2003 11:02:36 +0100
User-Agent: KMail/1.5.4
Cc: abrutschy@xylon.de, linux-kernel@vger.kernel.org
References: <200310271009.13054@totor.bouissou.net> <200310271049.32819.bzolnier@elka.pw.edu.pl> <200310271049.15348@totor.bouissou.net>
In-Reply-To: <200310271049.15348@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310271102.36476.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 of October 2003 10:49, Michel Bouissou wrote:
> Le Lundi 27 Octobre 2003 10:49, Bartlomiej Zolnierkiewicz a écrit :
> > This was discussed few times before.
> > Just enable "Special FastTrak feature" (overriding BIOS) config option.
>
> Uh. I may have misunderstood, but I understood that using this option would
> activate the controller's hardware RAID feature, which I don't want.

Quite opposite, it makes Linux use controller even if it was marked by BIOS
as disabled (for RAID purposes).

> I need to use the controller as a normal, non-RAID, IDE controller (and if
> ever if was setup as hardware RAID, I'm afraid it would destroy my data..)

It is software RAID (in BIOS/drivers) with propertiary format.

cheers,
--bartlomiej

