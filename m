Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272129AbRIJXHs>; Mon, 10 Sep 2001 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRIJXHb>; Mon, 10 Sep 2001 19:07:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18448 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272129AbRIJXHH>; Mon, 10 Sep 2001 19:07:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 01:14:31 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109101937370.2490-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109101937370.2490-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910230721Z16600-26187+42@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 12:39 am, Rik van Riel wrote:
> On Mon, 10 Sep 2001, Linus Torvalds wrote:
> 
> > (Ugly secret: because I tend to have tons of memory, I sometimes do
> >
> > 	find tree1 tree2 -type f | xargs cat > /dev/null
> 
> This suggests we may want to do agressive readahead on the
> inode blocks.

While that is most probably true, that wasn't his point.  He preloaded the 
page cache.

--
Daniel
