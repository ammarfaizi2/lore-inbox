Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTEKNZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTEKNZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:25:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63674 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261351AbTEKNZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:25:24 -0400
Date: Sun, 11 May 2003 15:37:46 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Grzegorz Wilk <toulouse@put.mielec.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SiS648 support for agpgart, kernel 2.4.21-rc2-ac1
In-Reply-To: <3EBE4B64.8070800@put.mielec.pl>
Message-ID: <Pine.SOL.4.30.0305111531430.4788-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 May 2003, Grzegorz Wilk wrote:

> Uzytkownik Bartlomiej Zolnierkiewicz napisal:
> > On Sun, 11 May 2003, Grzesiek Wilk wrote:
>
> >>One thing i'm not sure is in which agp mode it is working. SiS648 as well as
> >>R9k supports agp 3.0 but I don't think that generic sis driver does.
> >>(correct me if i'm wrong).
> >
> >
> > You are wrong, R9k -> no AGP3.0 ;-).
> > --
> > Bartlomiej
>
> I'm quite certain, that R2k _is_ agp 3.0 compatible.
> Following the specification at
> http://mirror.ati.com/products/pc/radeon9000pro/specs.html:
> "...with AGP 2X (3.3v), 4X (1.5V), 8X (0.8v) or Universal AGP 3.0 bus
> configuration (2X/4X/8X)."
>
> So is ATI making a mickey of me or what?

It is a bit misleading, read once again and look at "GENERAL FEATURES",
2X and 4X supported and 8X *compatible*.
Look also at R9200(PRO) spec, it is a R9000(PRO) with AGP3.0 support.

btw. R9100 is both faster/cheaper than R9000PRO.

--
Bartlomiej

