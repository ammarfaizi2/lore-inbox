Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSFJQjA>; Mon, 10 Jun 2002 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSFJQi7>; Mon, 10 Jun 2002 12:38:59 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:4342 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315528AbSFJQi6>; Mon, 10 Jun 2002 12:38:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 10 Jun 2002 10:37:02 -0600
To: Dan Aloni <da-x@gmx.net>
Cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
Message-ID: <20020610163702.GL20388@turbolinux.com>
Mail-Followup-To: Dan Aloni <da-x@gmx.net>,
	Lightweight patch manager <patch@luckynet.dynu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0206090641330.24893-100000@hawkeye.luckynet.adm> <20020610152824.GC9581@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2002  18:28 +0300, Dan Aloni wrote:
> This patch is against 2.5.21 vanilla. 
>  + replace __inline__ with inline.

Good.

>  + add the new list_move and list_move_tail mutators as inline functions.

Good.

>  + use list_t intead of struct list_head (no bytes we harmed, bla.. bla..)

I think you will find that the "struct list_head" is the preferred way
to go (which is why there are lots of "struct list_head" users in the
code and few "list_t" users.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

