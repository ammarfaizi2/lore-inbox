Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317725AbSGKCws>; Wed, 10 Jul 2002 22:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317726AbSGKCwr>; Wed, 10 Jul 2002 22:52:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:22035 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317725AbSGKCwq>; Wed, 10 Jul 2002 22:52:46 -0400
Date: Wed, 10 Jul 2002 23:55:04 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
Message-ID: <20020711025503.GB5973@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, R.E.Wolff@BitWizard.nl,
	linux-kernel@vger.kernel.org
References: <200207041724.KAA06758@adam.yggdrasil.com> <20020711124830.26e2388b.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020711124830.26e2388b.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 11, 2002 at 12:48:30PM +1000, Rusty Russell escreveu:
> On Thu, 4 Jul 2002 10:24:11 -0700
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> > smaller ones, in the case where there is substantial code that is not
> > needed for some configurations.
> 
> For God's sake, WHY?  Look at what you're doing to your TLB (and if you
> made IPv4 a removable module, I'll bet real money you have a bug unless
> you are *very* *very* clever).
> 
> Modules are not "free".  Sorry.

What about Andi Kleen patch to not use vmalloc (well, vmalloc is used as a
fallback) when loading modules but instead use big pages?  It is being
integrated in 2.4.20-pre, IIRC. IIRC with that there is still some issues, so
for enlightening the audience here, could you share your view on that patch? 8)

And for _debugging_ IPv4 maybe the modularisation, if Adam was clever, could
help somewhat.

- Arnaldo (who is stupid not to be using UML extensively, but this
           will change RSN 8) )
