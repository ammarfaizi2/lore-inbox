Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278682AbRJXRyz>; Wed, 24 Oct 2001 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278684AbRJXRyr>; Wed, 24 Oct 2001 13:54:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:55823 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278682AbRJXRyf>; Wed, 24 Oct 2001 13:54:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: VM
Date: Wed, 24 Oct 2001 19:56:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110240920530.14041-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.40.0110240920530.14041-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024175507Z16346-698+175@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 24, 2001 06:24 pm, David Lang wrote:
> the problem is that there isn't a patchset available from either aa or rik
> that converts one to the other, the only patchset readily available
> converts linus+aa to ac+rik this changes a lot more then just the VM stuff
> so without going to a lot of effort it's not possible to directly compare
> the two VM designs while keeping the rest of the kernel the same.

A non-kernel-hacker can easily make the patch.  Andrea posted a list of all 
the files affected back at the beginning of his 'vm rewrite' thread.

> > > Daniel, I think the suggestion isn't to break out the differences in a
> > > bunch of config options, but rather to do something like duplicating all
> > > files that are VM related into two files, foo.c becomes foo.aa.c and
> > > foo.rik.c at that point your config file either uses all the .rik files 
> > > or all the .aa files and both would be in the same tree, but not 
> > > interact with each other.
> > >
> > > yes, there would be a lot of duplication between them, but something 
> > > like this would let people compare the two directly without also having 
> > > all the other linus vs ac changes potentially affecting their tests.
> >
> > Patch and lilo are your friends.

--
Daniel
