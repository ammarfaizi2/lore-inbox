Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUFXO7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUFXO7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUFXO7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:59:30 -0400
Received: from witte.sonytel.be ([80.88.33.193]:47607 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265360AbUFXO7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:59:14 -0400
Date: Thu, 24 Jun 2004 16:59:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jamal Hadi Salim <hadi@znyx.com>, Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [NET]: Add tc extensions infrastructure.
In-Reply-To: <200406240108.i5O184QA014889@hera.kernel.org>
Message-ID: <Pine.GSO.4.58.0406241658050.5358@waterleaf.sonytel.be>
References: <200406240108.i5O184QA014889@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.1722.151.1, 2004/06/15 20:37:41-07:00, hadi@znyx.com
>
> 	[NET]: Add tc extensions infrastructure.
>
> 	Signed-off-by: Jamal Hadi Salim <hadi@znyx.com>
> 	Signed-off-by: David S. Miller <davem@redhat.com>

> diff -Nru a/net/sched/Kconfig b/net/sched/Kconfig
> --- a/net/sched/Kconfig	2004-06-23 18:08:15 -07:00
> +++ b/net/sched/Kconfig	2004-06-23 18:08:15 -07:00
> @@ -274,6 +274,22 @@
>  	  To compile this code as a module, choose M here: the
>  	  module will be called cls_u32.
>
> +config CLS_U32_PERF
> +	bool "     U32 classifier perfomance counters"
> +	depends on NET_CLS_U32
> +	help
> +	  gathers stats that could be used to tune u32 classifier perfomance.
                                                                  ^^^^^^^^^^
performance

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
