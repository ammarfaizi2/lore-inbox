Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318245AbSHDTip>; Sun, 4 Aug 2002 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSHDTip>; Sun, 4 Aug 2002 15:38:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1550 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318245AbSHDTio>; Sun, 4 Aug 2002 15:38:44 -0400
Date: Sun, 4 Aug 2002 16:41:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208041637030.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Linus Torvalds wrote:
> On Sun, 4 Aug 2002, Hubertus Franke wrote:
> >
> > As of the page coloring !
> > Can we tweak the buddy allocator to give us this additional functionality?
>
> I would really prefer to avoid this, and get "95% coloring" by just doing
> read-ahead with higher-order allocations instead of the current "loop
> allocation of one block".

OK, now I'm really going to start on some code to try and free
physically contiguous pages when a higher-order allocation comes
in ;)

(well, after this hamradio rpm I started)

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

