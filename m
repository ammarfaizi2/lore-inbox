Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264830AbUEPAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUEPAvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264847AbUEPAvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 20:51:50 -0400
Received: from florence.buici.com ([206.124.142.26]:63882 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264830AbUEPAvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 20:51:48 -0400
Date: Sat, 15 May 2004 17:51:46 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Message-ID: <20040516005146.GB23743@buici.com>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040515173430.GA28873@havoc.gtf.org> <200405151958.03322.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151958.03322.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 07:58:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > - host drivers should request/release IO resource
> > >   themelves and set hwif->mmio to 2
> >
> > Don't you mean, hwif->mmio==2 for MMIO hardware?
> 
> It is was historically for MMIO, now it means that driver
> handles IO resource itself (per comment in <linux/ide.h>).

If you are talking about this

        int             mmio;           /* hosts iomio (0) or custom (2) select 

do you really think that's enough?

