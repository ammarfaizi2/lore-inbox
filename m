Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTLKUiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTLKUiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:38:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:33753 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265486AbTLKUiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:38:06 -0500
X-Authenticated: #20450766
Date: Thu, 11 Dec 2003 21:10:02 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Tomas Martisius <tomas@puga.vdu.lt>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
In-Reply-To: <20031211111241.A16644@infradead.org>
Message-ID: <Pine.LNX.4.44.0312112107040.4669-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Christoph Hellwig wrote:

> On Thu, Dec 11, 2003 at 11:01:16AM +0200, Tomas Martisius wrote:
> > On Sun, 26 Oct 2003, Guennadi Liakhovetski posted patch for
> > AM53c974 driver. May be it is not perfect, but it is still not applied
> > to kernel source. I think it is better to have at least not broken
> > driver compared with existing.
> > I have Compaq deskpro XL 590 PC with integrated such controler, and this
> > driver affter applinig Guennadi Liakhovetski pach to 2.6.0-test11 source
> > works for me.
>
> The patch is broken but he has a better patch for the other driver for
> that hardware, that will hopefully go into 2.6.1.

Right, I think, you can safely use the patch for AM53C974 for now,
although it is broken, it should work for you (I have a slightly newer
Deskpro XL 5133), wait for 2.6.1 and just enable tmscsim:-)

Guennadi
---
Guennadi Liakhovetski


