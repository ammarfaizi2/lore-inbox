Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbRLTVm1>; Thu, 20 Dec 2001 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286405AbRLTVmT>; Thu, 20 Dec 2001 16:42:19 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9225 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286402AbRLTVmO>; Thu, 20 Dec 2001 16:42:14 -0500
Date: Thu, 20 Dec 2001 19:42:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <20011220203630.A204@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0112201941160.28489-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Pavel Machek wrote:

> > > Alan, you're mixing switch mm costs with cache image reload ones.
> > > Note that equal mm does not mean matching cache image, at all.
> >
> > They are often close to the same thing. Take a look at the constraints
> > on virtually cached processors like the ARM where they _are_ the same thing.
> >
> > Equal mm for cpu sucking tasks often means equal cache image. On the
>
> Really?
>
> I'd guess that if cpu-bound software wants to use clone(CLONE_VM) to
> gain some performance, it should better work "mostly" in different
> memory areas on different cpus... But I could be wrong.

I guess you never used xmms or mozilla, then ;)

(where threads seem to be used for different stages of
processing data ... not sure about mozilla)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

