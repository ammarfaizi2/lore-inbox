Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbRL0QBx>; Thu, 27 Dec 2001 11:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286321AbRL0QBm>; Thu, 27 Dec 2001 11:01:42 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10248 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286322AbRL0QBi>; Thu, 27 Dec 2001 11:01:38 -0500
Date: Thu, 27 Dec 2001 14:01:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: The direction linux is taking
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A36@ottonexc1.ottawa.loran.com>
Message-ID: <Pine.LNX.4.33L.0112271353370.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Dana Lacoste wrote:

> > >Not really. We do a passable job. Stuff gets dropped, lost,
> > >deferred and forgotten, applied when it conflicts with other work
> > >- much of this stuff that software wouldnt actually improve on over a
> > >person

> Q - Would CVS or Perforce or BitKeeper help fix these problems?
> A - No, the problem is one of organization, not accountability
>
> Maybe we should toss the original question and try to find ways
> to solve the organizational problems instead?

Sounds like an idea, except that up to now I haven't seen
any suitable solution for this.

The biggest problem right now seems to be that of patches
being dropped, which is a direct result of the kernel
maintainers not having infinite time.

A system to solve this problem would have to make it easier
for the kernel maintainers to remember patches, while at the
same time saving them time. I guess it would have something
like the following ingredients:
1. remember the patches and their descriptions
2. have the possibility for other people (subsystem maintainers?)
   to de-queue or update pending patches
3. check at each pre-release if the patches still apply, notify
   the submitter if the patch no longer applies
4. make an easy "one-click" solution for the maintainers to apply
   the patch and add a line to the changelog ;)
   (all patches apply without rejects, patches which don't apply
   have already been bounced back to the maintainer by #3)
5. after a new pre-patch, send the kernel maintainer a quick
   overview of pending patches
6. patches can get different priorities assigned, so the kernel
   maintainers can spend their time with the highest-priority
   patches first
7. .. ?

All in all, if such a system is ever going to exist, it
needs to _reduce_ the amount of work the kernel maintainers
need to do, otherwise it'll never get used.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

