Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUEPTbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUEPTbb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUEPTbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:31:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6877 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264801AbUEPTb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:31:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sun, 16 May 2004 21:33:30 +0200
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <200405151958.03322.bzolnier@elka.pw.edu.pl> <20040516005146.GB23743@buici.com>
In-Reply-To: <20040516005146.GB23743@buici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405162133.30859.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 of May 2004 02:51, Marc Singer wrote:
> On Sat, May 15, 2004 at 07:58:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > - host drivers should request/release IO resource
> > > >   themelves and set hwif->mmio to 2
> > >
> > > Don't you mean, hwif->mmio==2 for MMIO hardware?
> >
> > It is was historically for MMIO, now it means that driver
> > handles IO resource itself (per comment in <linux/ide.h>).
>
> If you are talking about this
>
>         int             mmio;           /* hosts iomio (0) or custom (2)
> select
>
> do you really think that's enough?

No and I didn't say this.  I tried to describe current state of affairs.
Don't blame me for cryptic comments in <linux/ide.h>.

