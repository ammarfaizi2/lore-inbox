Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286195AbRLJQQY>; Mon, 10 Dec 2001 11:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbRLJQQO>; Mon, 10 Dec 2001 11:16:14 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:49085 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286195AbRLJQPz>; Mon, 10 Dec 2001 11:15:55 -0500
Date: Mon, 10 Dec 2001 11:14:02 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.33L.0112101340030.4755-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.20.0112101112430.17492-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Rik van Riel wrote:

> On Mon, 10 Dec 2001, Alan Cox wrote:
> 
> > > I was hoping for something more elegant, but I am not adverse to writing
> > > my own get_free_page_from_range().
> >
> > Thats not a trivial task.
> 
> Especially because we never quite know the users of a
> physical page, so moving data around is somewhat hard.

I don't want to move them - I just want to collect all that are free and
then try to free some more. 

                            Vladimir Dergachev

> 
> cheers,
> 
> Rik
> -- 
> DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

