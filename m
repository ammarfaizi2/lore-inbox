Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVCTVA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVCTVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVCTVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:00:29 -0500
Received: from witte.sonytel.be ([80.88.33.193]:37810 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261283AbVCTVAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:00:06 -0500
Date: Sun, 20 Mar 2005 21:58:59 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Graf <tgraf@suug.ch>, "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PKT_SCHED]: Extended Matches API
In-Reply-To: <200503070214.j272EWfo024708@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0503202157350.27963@gorilla.sonytel.be>
References: <200503070214.j272EWfo024708@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005, Linux Kernel Mailing List wrote:
> ChangeSet 1.1982.66.2, 2005/02/15 12:13:15-08:00, davem@nuts.davemloft.net
> 
> 	[PKT_SCHED]: Extended Matches API


> --- a/net/sched/Kconfig	2005-03-06 18:14:44 -08:00
> +++ b/net/sched/Kconfig	2005-03-06 18:14:44 -08:00

> +config NET_EMATCH_STACK
> +	int "Stack size"
> +	depends on NET_EMATCH
> +	default "32"
> +	---help---
> +	  Size of the local stack variable used while evaluating the tree of
> +	  ematches. Limits the depth of the tree, i.e. the number of
> +	  encapsulated precedences. Every level requires 4 bytes of addtional
                                                                    ^^^^^^^^^
								    additional
> +	  stack space.
> +

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
