Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318849AbSHETIY>; Mon, 5 Aug 2002 15:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSHETIY>; Mon, 5 Aug 2002 15:08:24 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:54284 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318849AbSHETIW>; Mon, 5 Aug 2002 15:08:22 -0400
Date: Mon, 5 Aug 2002 21:11:57 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <20020805223016.A14603@namesys.com>
Message-ID: <Pine.LNX.4.44.0208052109350.31879-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 5 Aug 2002, Oleg Drokin wrote:

> Hello!
> 
> On Mon, Aug 05, 2002 at 08:19:05PM +0200, Roland Kuhn wrote:
> > > > > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 
> > >From there I get 'permission denied', but I got it somewhere else (google 
> > is great).
> > However, it does not apply cleanly to 2.4.19. It is already partly in, as 
> > it seems, but there are some rejects that are not obvious to fix for me. 
> > If this patch still makes sense, it would be great if someone with more 
> > knowledge/experience than me could have a look...
> 
> In the same dir there is 
> 03-data-logging-24.diff.gz
> It contains this patch and more stuff, you can try it.
> 
The same comment applies: I get 26 rejected hunks, most in journal.c. For 
some it could be a whitespace problem, because I could not immediately see 
the reason. Are some of these things already in 2.4.19?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

