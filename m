Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSLVBSc>; Sat, 21 Dec 2002 20:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSLVBSc>; Sat, 21 Dec 2002 20:18:32 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:47371 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264649AbSLVBSb>; Sat, 21 Dec 2002 20:18:31 -0500
Date: Sat, 21 Dec 2002 23:26:22 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: scott thomason <scott-kernel@thomasons.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel GCC Optimizations
Message-ID: <20021222012621.GA1212@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	scott thomason <scott-kernel@thomasons.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0212212307460.24398-100000@muur.intranet.vanheusden.com> <200212211920.28985.scott-kernel@thomasons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212211920.28985.scott-kernel@thomasons.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 21, 2002 at 07:20:28PM -0600, scott thomason escreveu:
> On Saturday 21 December 2002 04:10 pm, folkert@vanheusden.com wrote:
> > > > Is there any risk using -O3 instead of -O2 to compile the
> > > > kernel, and why?
> > >
> > > * It might uncover subtle bugs that would otherwise not occur.
> >
> > I wonder: for the sake of performance and good use of the precious
> > clock- cycles, shouldn't there be made a start of fixing those
> > bugs? Assuming that the bugs you're talking about are not
> > compiler-bugs, they *are* bugs in the code that should be fixed,
> > shouldn't they?
> >
> > > * Compiling with unusual options means that less people will know
> > > about any problems it causes you.
> >
> > So, let's make it -O6 per default for 2.7.x/3.1.x?
> 
> Let's not. I'd rather have the best kernel developers concentrating on 
> finishing important kernel features rather than digging their way out 
> of esoteric optimizer debugging sessions only to find it was a flaw 
> in gcc. The difference in performance boost between -O2 and greater 
> levels isn't usually enough to make a significant impact, not as 
> significant as the introduction of important new features, for 
> example.

Sometimes even _reducing_ the optimization for performance level makes it
faster, try with -Os. And this was already discussed here and elsewhere,
reading the archives would help a lot avoiding adding more noise to the list.

- Arnaldo
