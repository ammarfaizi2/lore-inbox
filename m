Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOBUA>; Thu, 14 Dec 2000 20:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOBTv>; Thu, 14 Dec 2000 20:19:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61568 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129267AbQLOBTV>;
	Thu, 14 Dec 2000 20:19:21 -0500
Date: Thu, 14 Dec 2000 19:48:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
In-Reply-To: <E146iof-0000OI-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0012141933390.10441-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Alan Cox wrote:

> > >Which works because in a normal compile environment they have /usr/include
> > >in their include path and /usr/include/linux points to the directory
> > >under /usr/src/linux/include.
> > 
> > No, that a redhat-ism.
> 
> Umm, its a most people except Debianism. People relied on it despite it
> being wrong. RH7 ships with a matching library set of headers. I got to close
> a lot of bug reports explaining to people that the new setup was in fact
> right 8(

	Actually, I suspect that quite a few of us had done that since long -
IIRC I've got burned on 1.2/1.3 and decided that I had enough. Bugger if I
remember what exactly it was - ISTR that it was restore(8) built with
1.3.<something> headers and playing funny games on 1.2, but it might be
something else...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
