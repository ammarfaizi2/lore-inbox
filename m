Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316461AbSEOSKa>; Wed, 15 May 2002 14:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316462AbSEOSK3>; Wed, 15 May 2002 14:10:29 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:14834 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316461AbSEOSK2>; Wed, 15 May 2002 14:10:28 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0205150931500.25038-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 19:07:16 +0100
Message-ID: <15953.1021486036@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  I try to avoid it as much as possible - it's actually more work for
> me, and about 50% of the BK patches I get don't even apply, because
> the person who sent them to me didn't send the whole series (ie left
> out some patch he didn't like or something like that). 

Oh Larry, are you listening? :)

>  I much prefer a bk pull, if the tree I pull from is clean (ie it
> doesn't have random crud in it, and it contains changsets from just
> one project). 

Noted. Thanks.

>  I personally like good changelog comments, and I find per-file
> comments to be a mistake. 

They can be, but sometimes it can be useful to put a high-level overview of
what you've done suitable for people who aren't familiar with the code into
the changeset comment, and describe exactly _how_ you did it in per-file
comments.

Which in the case of the patch I sent you yesterday would be something like
'fix zisofs breakage with shared zlib' on the changeset and 'set return 
value to trv not f in NEEDBYTE' in the lib/zlib_inflate/inflate.c log.

In this case, the latter can obviously be deduced from the diffs because
it's a one-liner, so perhaps it's a bad example -- but you don't always
actually want to have to refer to the diffs.

--
dwmw2


