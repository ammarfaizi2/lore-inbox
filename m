Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAERpu>; Fri, 5 Jan 2001 12:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129857AbRAERpk>; Fri, 5 Jan 2001 12:45:40 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:9484 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S129436AbRAERpZ>; Fri, 5 Jan 2001 12:45:25 -0500
Date: Fri, 5 Jan 2001 12:45:24 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Chris Evans <chris@scary.beasts.org>, Chris Mason <mason@suse.com>,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs patch for 2.4.0-final
In-Reply-To: <Pine.LNX.4.21.0101051454110.1295-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101051243200.323-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is ext2 upgradable to reiserfs or ext3?
If so, is it transparent..or like a umount, convert, mount..or do you like
have to import to a whole new partition?
Pointers to any docs of this sort would work for an answer

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

On Fri, 5 Jan 2001, Rik van Riel wrote:

> On Fri, 5 Jan 2001, Chris Evans wrote:
> > On Fri, 5 Jan 2001, Chris Mason wrote:
> > 
> > > > Could someone create one single patch for the 2.4.0 ?
> > > >
> > > I put all the code into CVS, and Yura is making the official patch now.
> > 
> > Since 2.4.0 final should fix a few i/o performance issues
> > (particuarly under heavy write loads), a quick few ext2 vs.
> > reiserfs benchmarks would make very interesting reading ;-)
> 
> An easy way to gain a performance edge on ext2 would
> be to do proper write clustering in the reiserfs
> ->writepage() function...  </hint>
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to loose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com.br/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
