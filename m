Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318810AbSHESPb>; Mon, 5 Aug 2002 14:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318811AbSHESPb>; Mon, 5 Aug 2002 14:15:31 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:45324 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318810AbSHESPa>; Mon, 5 Aug 2002 14:15:30 -0400
Date: Mon, 5 Aug 2002 20:19:05 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <20020805150436.A1176@namesys.com>
Message-ID: <Pine.LNX.4.44.0208052014220.31879-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg!

On Mon, 5 Aug 2002, Oleg Drokin wrote:

> Hello!
> 
> On Mon, Aug 05, 2002 at 12:51:35PM +0200, Roland Kuhn wrote:
> 
> > > Unfortunatelly dirty flag for reiserfs gets set way to often than necessary,
> > > we have some patches that should help this (from Chris Mason).
> > > You can try these for yourself too, for example from here:
> > > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 

>From there I get 'permission denied', but I got it somewhere else (google 
is great).

However, it does not apply cleanly to 2.4.19. It is already partly in, as 
it seems, but there are some rejects that are not obvious to fix for me. 
If this patch still makes sense, it would be great if someone with more 
knowledge/experience than me could have a look...

> No, it is not possible to begin "new journal" in reiser3.
> 
Is this going to change in reiser4?

> I know for sure that atime on mbox-style files used to determine which messages
> are new, and which are not. (N and O status in mutt).
> There may be other users as well.
> 
Yes, this kind of stuff. But we use it "only" to buffer some 600GB of 
valuable physics data before it can go to tape ;-)

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

