Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSB0LM2>; Wed, 27 Feb 2002 06:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292339AbSB0LMT>; Wed, 27 Feb 2002 06:12:19 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:64009 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292131AbSB0LMJ>;
	Wed, 27 Feb 2002 06:12:09 -0500
Date: Wed, 27 Feb 2002 08:11:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <m.knoblauch@teraport.de>
Cc: <Martin.Bligh@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in thetree
In-Reply-To: <3C7CBDC0.9F9CDBAC@TeraPort.de>
Message-ID: <Pine.LNX.4.33L.0202270811040.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Martin Knoblauch wrote:
> Rik van Riel wrote:
> > On Wed, 27 Feb 2002, Martin Knoblauch wrote:
> >
> > > > > Not to begin the flamewar, but no thanks. rmap-12f blows -aa away AFAIK
> > > > > on this P200 w/ 64MB ram.
> > > >
> > > > rmap still sucks on large systems though. I'd love to see rmap
> > > > in the main kernel, but it needs to get the scalability fixed first.
> > > > The main problem seems to be pagemap_lru_lock ... Rik & crew
> > > > know about this problem, but let's give them some time to fix it
> > > > before rmap gets put into mainline ....
> > >
> > >  just out of curiosity: where does "large systems" start in your
> > > context?
> >
> > My guess it would start at about 4 or 8 CPUs.
> >
> > Systems which have a lot of pagetable overhead would also
> > suffer with -rmap, until -rmap supports pte_highmem.
>
>  So, what about a Dual-Athlon system with 2-3 GB of memory? Large
> system, or just a peanut? :-)

Unless you're overburdening the system with Oracle -rmap should
run just fine.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

