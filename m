Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272540AbTGaPm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTGaPlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:41:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39872 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272513AbTGaPbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:31:41 -0400
Date: Thu, 31 Jul 2003 12:26:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marc Heckmann <mh@nadir.org>, linux-kernel@vger.kernel.org
Subject: Re: UP IO-APIC fix in 2.4.22-pre?
In-Reply-To: <200307310821.27648.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0307311225350.4226@freak.distro.conectiva>
References: <20030731002847.GA3549@nadir.org> <200307310821.27648.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marc,

I just applied that patch in the 2.4 BK tree.

-pre10 will be release today with it included.

On Thu, 31 Jul 2003, Marc-Christian Petersen wrote:

> On Thursday 31 July 2003 02:28, Marc Heckmann wrote:
>
> Hi Marc,
>
> > I was just wondering about the bugfix for UP IO-APIC that is in 2.4-ac
> > and that went into 2.5:
> > http://linux.bkbits.net:8080/linux-2.5/cset@1.1455.1.9
> > Will it make it into 2.4.22? From what I understand this fixes the
> > following problem that many of us are seeing:
> > hda: dma_timer_expiry: dma status == 0x24
> > hda: lost interrupt
> > hda: dma_intr: bad DMA status (dma_stat=30)
> > hda: dma_intr: status=0x50 { DriveReady SeekComplete }
>
> I sent it to Marcelo yesterday. In the meantime you might want to try out the
> attached patch ontop of 2.4.22-pre9 and see if it fixes the problems for you.
>
> ciao, Marc
>
