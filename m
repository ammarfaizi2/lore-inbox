Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278678AbRJXRpz>; Wed, 24 Oct 2001 13:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278680AbRJXRpq>; Wed, 24 Oct 2001 13:45:46 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:28117 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S278678AbRJXRpd>; Wed, 24 Oct 2001 13:45:33 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Date: Wed, 24 Oct 2001 09:24:10 -0700 (PDT)
Subject: Re: VM
In-Reply-To: <20011024144423Z16306-698+146@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.40.0110240920530.14041-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the problem is that there isn't a patchset available from either aa or rik
that converts one to the other, the only patchset readily available
converts linus+aa to ac+rik this changes a lot more then just the VM stuff
so without going to a lot of effort it's not possible to directly compare
the two VM designs while keeping the rest of the kernel the same.

David Lang



 On Wed, 24 Oct 2001, Daniel Phillips wrote:

> Date: Wed, 24 Oct 2001 16:44:53 +0200
> From: Daniel Phillips <phillips@bonn-fries.net>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Keith Owens <kaos@ocs.com.au>,
>      Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: VM
>
> On October 23, 2001 06:14 pm, David Lang wrote:
> > Daniel, I think the suggestion isn't to break out the differences in a
> > bunch of config options, but rather to do something like duplicating all
> > files that are VM related into two files, foo.c becomes foo.aa.c and
> > foo.rik.c at that point your config file either uses all the .rik files or
> > all the .aa files and both would be in the same tree, but not interact
> > with each other.
> >
> > yes, there would be a lot of duplication between them, but something like
> > this would let people compare the two directly without also having all the
> > other linus vs ac changes potentially affecting their tests.
>
> Patch and lilo are your friends.
>
> --
> Daniel
>
