Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261428AbSJCQt4>; Thu, 3 Oct 2002 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJCQt4>; Thu, 3 Oct 2002 12:49:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261428AbSJCQtq>; Thu, 3 Oct 2002 12:49:46 -0400
Date: Thu, 3 Oct 2002 09:56:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jbradford@dial.pipex.com, <jgarzik@pobox.com>, <kessler@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <saw@saw.sw.com.sg>, <rusty@rustcorp.com.au>,
       <richardj_moore@uk.ibm.com>
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
 logging macros, SCSI RAIDdevice)
In-Reply-To: <1033663078.28850.19.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210030952010.2067-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Oct 2002, Alan Cox wrote:
> > 
> > "Stick to"? We've never had that as any criteria for major numbers in the
> > kernel. Binary compatibility has _never_ been broken as a release policy,
> > only as a "that code is old, and we've given people 5 years to migrate to
> > the new system calls, the old ones are TOAST".
> 
> We've generally done better than that. Libc 2.2.2 stil works

We have removed _some_ stuff, and we've definitely broken some of the more
esoteric configuration stuff (ie things like "top" and "ps" and "ifconfig"
have broken multiple times over the last 11 years).

And that "old_stat()" thing really ought to go some day.. It's not much of
a support burden, and yeah, we can point people to "that old a.out binary
from 1993 still works fine", so I guess we'll keep it another ten years,
but at this point that has less to do with technical judgement than with
sentimentality, I think ;^)

But yeah, I think on the whole we've done pretty well on being binary 
compatible.

		Linus

