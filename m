Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbSIYJrL>; Wed, 25 Sep 2002 05:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbSIYJrL>; Wed, 25 Sep 2002 05:47:11 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:27655 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261951AbSIYJrK>; Wed, 25 Sep 2002 05:47:10 -0400
Date: Wed, 25 Sep 2002 06:51:51 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [re-ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
Message-ID: <20020925095151.GA8262@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Arjan van de Ven <arjanv@redhat.com>
References: <Pine.LNX.4.44.0209251051190.6169-100000@localhost.localdomain> <Pine.LNX.4.44.0209251128070.7225-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209251128070.7225-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 25, 2002 at 11:32:24AM +0200, Ingo Molnar escreveu:
> 
> okay, this time the correct patch against BK-curr is included:

<SNIP>

> diff -rNu linux.orig/arch/i386/kernel/process.c.rej linux/arch/i386/kernel/process.c.rej
> --- linux.orig/arch/i386/kernel/process.c.rej	Thu Jan  1 01:00:00 1970
> +++ linux/arch/i386/kernel/process.c.rej	Wed Sep 25 11:25:33 2002
                                      ^^^^
                                      ^^^^
                                      ^^^^

Oops :-)

> @@ -0,0 +1,29 @@
> +***************
> +*** 159,172 ****
> +  void show_regs(struct pt_regs * regs)
> +  {
> +  	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
