Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEQ4p>; Fri, 5 Jan 2001 11:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbRAEQ4h>; Fri, 5 Jan 2001 11:56:37 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14074 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129183AbRAEQ4Y>; Fri, 5 Jan 2001 11:56:24 -0500
Date: Fri, 5 Jan 2001 14:54:53 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Evans <chris@scary.beasts.org>
cc: Chris Mason <mason@suse.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: reiserfs patch for 2.4.0-final
In-Reply-To: <Pine.LNX.4.30.0101051555240.28552-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.21.0101051454110.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Chris Evans wrote:
> On Fri, 5 Jan 2001, Chris Mason wrote:
> 
> > > Could someone create one single patch for the 2.4.0 ?
> > >
> > I put all the code into CVS, and Yura is making the official patch now.
> 
> Since 2.4.0 final should fix a few i/o performance issues
> (particuarly under heavy write loads), a quick few ext2 vs.
> reiserfs benchmarks would make very interesting reading ;-)

An easy way to gain a performance edge on ext2 would
be to do proper write clustering in the reiserfs
->writepage() function...  </hint>

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
