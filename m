Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317765AbSGKFJd>; Thu, 11 Jul 2002 01:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSGKFJc>; Thu, 11 Jul 2002 01:09:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54994 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317765AbSGKFJa>;
	Thu, 11 Jul 2002 01:09:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Wed, 10 Jul 2002 23:55:04 -0300."
             <20020711025503.GB5973@conectiva.com.br> 
Date: Thu, 11 Jul 2002 15:16:22 +1000
Message-Id: <20020711051232.324454224@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020711025503.GB5973@conectiva.com.br> you write:
> Em Thu, Jul 11, 2002 at 12:48:30PM +1000, Rusty Russell escreveu:
> > On Thu, 4 Jul 2002 10:24:11 -0700
> > "Adam J. Richter" <adam@yggdrasil.com> wrote:
> > > smaller ones, in the case where there is substantial code that is not
> > > needed for some configurations.
> > 
> > For God's sake, WHY?  Look at what you're doing to your TLB (and if you
> > made IPv4 a removable module, I'll bet real money you have a bug unless
> > you are *very* *very* clever).
> > 
> > Modules are not "free".  Sorry.
> 
> What about Andi Kleen patch to not use vmalloc (well, vmalloc is used as a
> fallback) when loading modules but instead use big pages?  It is being
> integrated in 2.4.20-pre, IIRC. IIRC with that there is still some issues, so
> for enlightening the audience here, could you share your view on that patch? 
8)

Sure, but there was no indication that Adam was using such a patch 8)

> And for _debugging_ IPv4 maybe the modularisation, if Adam was clever, could
> help somewhat.

Definitely.  For debugging purposes, you don't need reference
counting: when the hacker says "remove it", you remove it. 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
