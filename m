Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSHDSlV>; Sun, 4 Aug 2002 14:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318189AbSHDSlV>; Sun, 4 Aug 2002 14:41:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25863 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318188AbSHDSlU>; Sun, 4 Aug 2002 14:41:20 -0400
Date: Sun, 4 Aug 2002 15:44:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Hans Reiser <reiser@namesys.com>
cc: Andreas Gruenbacher <agruen@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
In-Reply-To: <3D4D72EB.7000809@namesys.com>
Message-ID: <Pine.LNX.4.44L.0208041543450.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Hans Reiser wrote:
> Rik van Riel wrote:
>
> >Nope, the idea is to push all caches according to size, but
> >often-used caches should shrink less than caches that are
> >hardly ever used.
>
> Do you let the subcache decide how to move the aging hand and track it?
>  Have I convinced you of that one yet?  Or is it still page based?

Linus has indicated that he would like to have it page based,
but implementation issues point towards letting the subcache
manage its objects by itself ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

