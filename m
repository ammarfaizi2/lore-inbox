Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbTFQMZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbTFQMZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:25:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:9675 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264687AbTFQMZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:25:52 -0400
Date: Tue, 17 Jun 2003 14:39:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: o net: use hlist for struct sock hash lists
In-Reply-To: <200306162214.h5GMEG3k016075@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0306171437430.17930-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Linux Kernel Mailing List wrote:

> ChangeSet 1.1320, 2003/06/16 12:11:44-03:00, acme@conectiva.com.br
> 
> 	o net: use hlist for struct sock hash lists

Causes the following warning:

| net/ipx/af_ipx.c:276: warning: declaration of `node' shadows a parameter

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

