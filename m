Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbTIVIgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 04:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTIVIgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 04:36:15 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:31176 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262438AbTIVIgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 04:36:14 -0400
Date: Mon, 22 Sep 2003 10:36:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre5
In-Reply-To: <Pine.LNX.4.44.0309211438440.17528-100000@logos.cnet>
Message-ID: <Pine.GSO.4.21.0309221034310.4957-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003, Marcelo Tosatti wrote:
> Here goes -pre5. It contains a bunch of important ACPI fixes, adds a very
> important missing hunk from -aa VM merge, amongst others.

A small fix from the m68k warning police (out is no longer used):

--- linux-2.4.23-pre5/mm/page_alloc.c.orig	Mon Sep 22 08:43:17 2003
+++ linux-2.4.23-pre5/mm/page_alloc.c	Mon Sep 22 10:26:35 2003
@@ -317,7 +317,6 @@
 		}
 		current->nr_local_pages = 0;
 	}
- out:
 	*freed = __freed;
 	return page;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

