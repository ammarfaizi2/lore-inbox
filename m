Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbRGDGvK>; Wed, 4 Jul 2001 02:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266510AbRGDGvA>; Wed, 4 Jul 2001 02:51:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:20236 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265586AbRGDGuz>; Wed, 4 Jul 2001 02:50:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ph. Marek" <marek@bmlv.gv.at>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Ideas for TUX2
Date: Wed, 4 Jul 2001 08:54:24 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3.0.6.32.20010703082513.0091f900@pop3.bmlv.gv.at> <3.0.6.32.20010704081621.00921a60@pop3.bmlv.gv.at>
In-Reply-To: <3.0.6.32.20010704081621.00921a60@pop3.bmlv.gv.at>
MIME-Version: 1.0
Message-Id: <01070408542401.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 July 2001 08:16, Ph. Marek wrote:
> >> If a file's data has been changed, it suffices to update the inode and
> >> the of free blocks bitmap (fbb).
> >> But updating them in one go is not possible
> >
> >You seem to have missed some fundamental understanding of
> >exactly how phase tree works; the wohle point of phase
> >tree is to make atomic updates like this possible!
>
> Well, my point was, that with several thousand inodes spread over the disk
> it won't always be possible to update the inode AND the fbb in one go.
> So I proposed the 2nd inode with generation counter!

The cool thing is, it *is* possible, read how here:

  http://nl.linux.org/~phillips/tux2/phase.tree.tutorial.html

--
Daniel
