Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130585AbRCISkk>; Fri, 9 Mar 2001 13:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130586AbRCISka>; Fri, 9 Mar 2001 13:40:30 -0500
Received: from waste.org ([209.173.204.2]:33551 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130585AbRCISkJ>;
	Fri, 9 Mar 2001 13:40:09 -0500
Date: Fri, 9 Mar 2001 12:39:06 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James R Bruce <bruce+@andrew.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: quicksort for linked list
In-Reply-To: <E14bLPz-0004r4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103091227210.5548-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Alan Cox wrote:

> > Quicksort works just fine on a linked list, as long as you broaden
> > your view beyond the common array-based implementations.  See
> > "http://www.cs.cmu.edu/~jbruce/sort.cc" for an example, although I
> > would recommend using a radix sort for linked lists in most situations
> > (sorry for the C++, but it was handy...).
>
> In a network environment however its not so good. Quicksort has an N^2
> worst case and the input is controlled by a potential enemy.

It's not too hard to patch that up, eg quickersort. N^2 isn't too bad for
short queues anyway especially considering the complexity of the
alternatives.

> Im dubious about anyone doing more than simple bucket sorting for packets.

Assume you mean sorting into hash buckets as opposed to "count the number
of occurrences of each type of element in a narrow range, discarding the
actual element". Most hashes are subvertible too and probably don't fair
any better than N^2.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

