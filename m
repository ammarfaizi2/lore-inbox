Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288269AbSACSVv>; Thu, 3 Jan 2002 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288275AbSACSVk>; Thu, 3 Jan 2002 13:21:40 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:47876 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288269AbSACSV1>;
	Thu, 3 Jan 2002 13:21:27 -0500
Date: Thu, 3 Jan 2002 15:32:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <akpm@zip.com.au>, <znmeb@aracnet.com>,
        <art@lsr.nei.nih.gov>, <linux-kernel@vger.kernel.org>
Subject: Re: kswapd etc hogging machine
In-Reply-To: <20020103182756.237453bd.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L.0201031531090.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Stephan von Krawczynski wrote:
> On Thu, 3 Jan 2002 14:51:01 -0200 (BRST)
> Rik van Riel <riel@conectiva.com.br> wrote:
> > On Thu, 3 Jan 2002, Alan Cox wrote:
> >
> > > 2.4.1x VM code is performing better under light loads but its
> > > absolutely and completely hopeless under a real paging load. 2.4.17-aa
> > > is somewhat better interestingly.
> >
> > A quick 'make -j bzImage' test I did yesterday got the system
> > to use near 70% of its CPU time in user mode and 30% in system
> > mode. This was with 2.4.17-rmap-10b, btw.
>
> And what kind of an argument is this? This is an honest question,
> really. If I do this make I end up around 80-90% in user mode and the
> rest in system on a standard 2.4.17 SMP box (configured with too less
> swap btw).

How much memory does that box have ?

In my case it was with 512 MB of RAM, the system went almost
900 MB into swap.

If your machine has one GB of RAM (or more), I expect the gccs
to fit mostly into RAM, which would give much better behaviour.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

