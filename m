Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSGTOUX>; Sat, 20 Jul 2002 10:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSGTOUW>; Sat, 20 Jul 2002 10:20:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15878 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317402AbSGTOUV>; Sat, 20 Jul 2002 10:20:21 -0400
Date: Sat, 20 Jul 2002 11:22:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Craig Kulesa <ckulesa@as.arizona.edu>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] Updated VM statistics patch
In-Reply-To: <Pine.LNX.4.44.0207200645360.6298-100000@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.44L.0207201122220.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, Craig Kulesa wrote:
> On Sat, 20 Jul 2002, Rik van Riel wrote:
>
> > Except for the fact that you'll count every new page allocation
> > as an activation, which isn't quite the intended behaviour ;)
>
> *thwaps forehead*   Ohhh, quite right.  Darn.  :)
>
> Hmmm.  Does it sound acceptable to still increment pgdeactivate in
> mm_inline.h, and explicitly put hooks for pgactivate in the select
> places where pages really _are_ being 'reactivated'?

Acceptable, sure ... but probably not worth it as Linus merged
the VM statistics into his tree yesterday afternoon.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

