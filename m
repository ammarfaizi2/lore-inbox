Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318301AbSHEFif>; Mon, 5 Aug 2002 01:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318305AbSHEFif>; Mon, 5 Aug 2002 01:38:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:36106 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318301AbSHEFie>; Mon, 5 Aug 2002 01:38:34 -0400
Date: Mon, 5 Aug 2002 02:42:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
Message-ID: <20020805054206.GB7946@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain> <m3u1mb5df3.fsf@averell.firstfloor.org> <ail2qh$bf0$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ail2qh$bf0$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 05, 2002 at 05:35:13AM +0000, Linus Torvalds escreveu:
> This will break _horribly_ when (if) glibc starts using SSE2 for things
> like memcpy() etc.

Humm, related, wasn't one way of having userspace have access to the kernel
optimized versions of memcpy et al, thru a page with these functions that would
be mapped into the process address space (don't remember exact details)
something still being considered?

- Arnaldo
