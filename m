Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275351AbTHGOpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275355AbTHGOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:45:39 -0400
Received: from proibm3.portoweb.com.br ([200.248.222.108]:51658 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S275351AbTHGOpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:45:21 -0400
Date: Thu, 7 Aug 2003 11:47:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Christoph Hellwig <hch@lst.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <Mitch@0Bits.COM>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
In-Reply-To: <20030807142624.GA29208@lst.de>
Message-ID: <Pine.LNX.4.44.0308071147370.2696-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Aug 2003, Christoph Hellwig wrote:

> > I dont understand how the vmap change can break DRM. 
> > 
> > The vmap patch only changes internal mm/vmalloc.c code (vmalloc() call
> > acts exactly the same way as before AFAICS).
> > 
> > Anyway, Mitch (or Erik who's seeing the problem), can please revert the
> > vmap() change to check if its causing the mentioned problem? 
> 
> vmap() doesn't break DRM.  The external drm code just detects that
> vmap is present and then uses the new interface, but this new code
> also expects a new exported symbol.

And which symbol is that? 

> The DRM code in your tree is completly unaffected.

Fine.

