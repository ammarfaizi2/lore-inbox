Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbREWVMi>; Wed, 23 May 2001 17:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263260AbREWVM3>; Wed, 23 May 2001 17:12:29 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:46684 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263258AbREWVMX>;
	Wed, 23 May 2001 17:12:23 -0400
Message-ID: <20010523231213.A11564@win.tue.nl>
Date: Wed, 23 May 2001 23:12:13 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Dave Mielke <dave@mielke.cc>,
        "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount by label not working.
In-Reply-To: <Pine.LNX.4.30.0105231505330.995-100000@dave.private.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0105231505330.995-100000@dave.private.mielke.cc>; from Dave Mielke on Wed, May 23, 2001 at 03:11:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 03:11:41PM -0400, Dave Mielke wrote:
> Using kernel 2.2.17-14 as supplied by RedHat, and using mount from
> mount-2.9u-4, mounting by label using the -L option does not work.
> 
>     mount -L backup1 /a
>     mount: no such partition found
> 
> The mount man page says that "/proc/partitions" must exist.
> 
>     ls -l /proc/partitions
>     -r--r--r--   1 root     root            0 May 23 15:10 /proc/partitions
> 
> Does something need to be enabled to make this work? What else might I be doing
> wrong?

Everything

> I believe that the Bible is the
> Word of God. Please contact me
> if you're concerned about Hell.

Hm. Hell - that h must have been a k - it must mean something like
the secret or hidden place, as in Latin celare or Greek kaluptein
and in cellar and conceal and occult.
Much more can be said. Some other time.

Hmm. God. Less easy. Will think about that one.
You use it as if it were a proper name, but that must be a mistake.
Gothic has "guth", a neuter consonant stem. And it is the same in
Old Nordic. Maybe the word is Germanic only? Or connection with Sanskrit hu-?

Bible. Greek: biblion. Booklet.


But concerning mount [French monter, Latin montare etc]:
(i) Your version is ancient, but it might be good enough.
(ii) Labels as used in "mount -L label" are ext2 labels only
(well, xfs also works if I recall correctly)
(iii) I forgot to implement a crystal ball, so mount is not
very good in divining [yes, that is related to the old
indoeuropean words for god] where the devices are with a
given label. However, it will try everything mentioned in /proc/partitions.
In your case that is a very short list.

Andries
