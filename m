Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTIVJJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 05:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTIVJJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 05:09:56 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:26386 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262575AbTIVJJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 05:09:54 -0400
Date: Mon, 22 Sep 2003 06:12:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre5
In-Reply-To: <Pine.GSO.4.21.0309221034310.4957-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0309220612080.32694-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Sep 2003, Geert Uytterhoeven wrote:

> On Sun, 21 Sep 2003, Marcelo Tosatti wrote:
> > Here goes -pre5. It contains a bunch of important ACPI fixes, adds a very
> > important missing hunk from -aa VM merge, amongst others.
> 
> A small fix from the m68k warning police (out is no longer used):
> 
> --- linux-2.4.23-pre5/mm/page_alloc.c.orig	Mon Sep 22 08:43:17 2003
> +++ linux-2.4.23-pre5/mm/page_alloc.c	Mon Sep 22 10:26:35 2003
> @@ -317,7 +317,6 @@
>  		}
>  		current->nr_local_pages = 0;
>  	}
> - out:
>  	*freed = __freed;
>  	return page;
>  }

Applied

Thanks Geert.

