Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSGQMIZ>; Wed, 17 Jul 2002 08:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSGQMIY>; Wed, 17 Jul 2002 08:08:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18195 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S312938AbSGQMIX>; Wed, 17 Jul 2002 08:08:23 -0400
Date: Wed, 17 Jul 2002 09:10:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <20020717092446.A4329@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0207170908130.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Russell King wrote:

> I'm puzzling over this difference:
>
> > --- /dev/null	Thu Aug 30 13:30:55 2001
> > +++ 2.5.26-akpm/include/asm-arm/proc-armv/rmap.h	Tue Jul 16 21:59:40 2002

Then I guess I messed up the ARM rmap.h for 2.5.

I knew it had to be different than the 2.4 one somehow and
was under the impression that you changed the pagetable
layout in 2.5 to have "4 kB page tables" with 2 kB hardware
and 2 kB software page tables in the same page.

The page->mm thing is a stupid, stupid typo.

I guess akpm didn't have an ARM machine for testing, either ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

