Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSGJUkh>; Wed, 10 Jul 2002 16:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSGJUkg>; Wed, 10 Jul 2002 16:40:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:4624 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317611AbSGJUke>; Wed, 10 Jul 2002 16:40:34 -0400
Date: Wed, 10 Jul 2002 17:42:41 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Sebastian Droege <sebastian.droege@gmx.de>
cc: linux-kernel@vger.kernel.org, <akpm@zip.com.au>, <linux-mm@kvack.org>
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
In-Reply-To: <20020710193545.272bedab.sebastian.droege@gmx.de>
Message-ID: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Sebastian Droege wrote:
> On Sat, 6 Jul 2002 02:31:38 -0300 (BRT)
> Rik van Riel <riel@conectiva.com.br> wrote:
>
> > If you have some time left this weekend and feel brave,
> > please test the patch which can be found at:
> >
> > 	http://surriel.com/patches/2.5/2.5.25-rmap-akpmtested

> after running your patch some time I have to say that the old VM
> implementation and the full rmap patch (by Craig Kulesa) was better. The
> system becomes very slow and has to swap in too much after some uptime
> (4 hours - 2 days) and memory intensive tasks...
> Maybe this happens only to me but it's fully reproducable

It's a known problem with use-once. Users of plain 2.4.18
are complaining about it, too.

This is something to touch on after the rmap mechanism
has been merged, Linus has indicated that he wants to merge
the thing in small bits so that's what we'll be doing ;)

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

