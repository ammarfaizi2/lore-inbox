Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSERPGb>; Sat, 18 May 2002 11:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSERPGa>; Sat, 18 May 2002 11:06:30 -0400
Received: from otter.mbay.net ([206.55.237.2]:64781 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S313181AbSERPG3>;
	Sat, 18 May 2002 11:06:29 -0400
Date: Sat, 18 May 2002 08:06:19 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <Pine.LNX.4.44.0205171936220.1524-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.20.0205180805280.8351-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe what is needed is a copy_from_user debug mode, like slab poisoning.

john alvord

On Fri, 17 May 2002, Linus Torvalds wrote:

> 
> 
> On Fri, 17 May 2002, Rusty Russell wrote:
> >
> > Sorry I wasn't clear: I'm saying *replace*, not add,
> 
> Ok, let _me_ be clear: replacing them with an inferior product that cannot
> tell you partial copies is not going to happen. Not now, not ever. You
> would break all the users who _require_ knowing about a read() that only
> gave you 5 out of 50 bytes.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

