Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRCJX4J>; Sat, 10 Mar 2001 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbRCJXz7>; Sat, 10 Mar 2001 18:55:59 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:49934 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S131158AbRCJXzw>; Sat, 10 Mar 2001 18:55:52 -0500
Date: Sat, 10 Mar 2001 16:54:58 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Martin Mares <mj@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Message-ID: <20010310165458.A7565@mail.harddata.com>
In-Reply-To: <3AA89624.46DBADD7@idb.hist.no> <200103091152.MAA31645@cave.bitwizard.nl> <20010309152902.A1219@mail.harddata.com> <20010310195006.A2670@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20010310195006.A2670@albireo.ucw.cz>; from Martin Mares on Sat, Mar 10, 2001 at 07:50:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2001 at 07:50:06PM +0100, Martin Mares wrote:
> Hello!
> 
> > Well, not really in this situation, after a simple modification.  It is
> > trivial to show that using "shorter interval sorted first" approach one
> > can bound an amount of an extra memory, on stack or otherwise, and by a
> > rather small number.
> 
> By O(log N) which is in reality a small number :)

Assuming that we sort a full range of 32-bit numbers (pointers on a
32-bit CPU, for example, are numbers of that kind but usually a range
can be narrowed down quite substantially) then with a bit of a careful
programming you need, I think, something like 16 extra 4-byte words or
maybe even a bit less.  I do not remember precisely, as I was doing this
exercise a long time ago, but even if this is 32, and you need carefuly
constructed example to need them all these extra cells, I still think
that this is not a huge amount of memory.  Especially when every element
of a list you are sorting is likely quite a bit bigger.

Exponents are something which grows these numbers pretty fast. :-)

  Michal
