Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129222AbRBCHOW>; Sat, 3 Feb 2001 02:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129395AbRBCHON>; Sat, 3 Feb 2001 02:14:13 -0500
Received: from www.wen-online.de ([212.223.88.39]:22542 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129219AbRBCHN7>;
	Sat, 3 Feb 2001 02:13:59 -0500
Date: Sat, 3 Feb 2001 08:13:46 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: RAMFS
In-Reply-To: <Pine.Linu.4.10.10102022151400.490-100000@mikeg.weiden.de>
Message-ID: <Pine.Linu.4.10.10102030749510.1295-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Mike Galbraith wrote:

> > Where exactly do you see the leaks?
> 
> (I don't have a solid grip yet.. just starting to seek)

Heh.  I figured this must be a nice defenseless little buglet
I could pick on (ramfs is pretty darn simple).  Critter might
not be quite as defenseless as I presumed ;-)

Using ramfs under vm pressure breaks (hmm.. spinlock) instantly
on my UP box.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
