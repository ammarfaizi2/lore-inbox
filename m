Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283310AbRLWDlT>; Sat, 22 Dec 2001 22:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283288AbRLWDlJ>; Sat, 22 Dec 2001 22:41:09 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38575 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S283287AbRLWDlC>;
	Sat, 22 Dec 2001 22:41:02 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 23 Dec 2001 03:40:56 GMT
Message-Id: <UTC200112230340.DAA66334.aeb@cwi.nl>
To: bcrl@redhat.com, cw@f00f.org
Subject: Re: Configure.help editorial policy
Cc: esr@thyrsus.com, garfield@irving.iisd.sra.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:

> If you think GB == 1000^3, then please go "correct" all the DRAM 
> manufacturers out in the world.  They just sent me 1GB of ram and
> it's coming up as 1073741824 bytes.

Oh, please - must we have this same discussion every year?


If someone uses an approximate value in some context then that
- is desirable if it is more convenient
- is admissable either (i) if greater precision is not of interest
  (or unavailable), or (ii) when the approximate value suffices to
  derive the exact value uniquely.


When things come in power-of-two sizes then no confusion is
possible if you use a decimal prefix: in reality the nearest
power of two is meant. Thus there is no urgent reason to be
precise when talking about the size of memory modules.
If you say 1GB, that is an American billion bytes, everybody
will assume that in fact the size was 1073741824 bytes.
Of course this will change when technology changes and memory
comes in arbitrarily sized units, like disks today.


These remarks taken together mean that it is not often necessary
to use these newfangled abbreviations like GiB or words like
gibibyte. Often precision is not required. Or precision is required
but the precise size is clear from the context.

But it is a serious mistake to doubt G = 1000^3.
k, M, G have one and only one meaning.
Just like "thousand" has only one meaning and still one can say
that this thing, that cost $1049, was bought for a thousand bucks.


Disks do not come in power-of-two sizes. So when talking about
disk sizes there is no "he says 1000000000 but it must be
a power of two so he must mean 1073741824". No, for disk sizes
it is just "he says 1000000000 so that is it".


In standard texts and other places where there must not be
any ambiguity one uses KiB, MiB, GiB. Also in a context where
binary and decimal units are both used it is clean to
separate them. When Linux boots, I see

hdf: 120064896 sectors (61473 MB) w/2048KiB Cache

and you see that the MB is decimal and the KiB binary. Good.


Concerning this Configure.help stuff, clearly it is not very
important what is written, but GiB is slightly better than GB,
and I doubt it would lead to any problems. People who have
never seen GiB will probably read it as gigabyte, and that is
approximately right.

Concerning the future of this standard for binary prefixes,
it looks like scientists and engineers like them and are
careful to distinguish G and Gi; in the open software world
programs are slowly adapted to correct usage; Microsoft has
not yet heard about the difference between GB and GiB.

Andries
