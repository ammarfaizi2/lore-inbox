Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273601AbRIUQZl>; Fri, 21 Sep 2001 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273613AbRIUQZd>; Fri, 21 Sep 2001 12:25:33 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:24450 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S273601AbRIUQZQ>; Fri, 21 Sep 2001 12:25:16 -0400
Date: Sat, 22 Sep 2001 00:21:05 +0800 (HKT)
From: David Chow <davidtl@rcn.com.hk>
X-X-Sender: <davidtl@uranus.planet.rcn.com.hk>
To: Alexander Viro <viro@math.psu.edu>
cc: Oystein Viggen <oysteivi@tihlde.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Wrapfs a stackable file system
In-Reply-To: <Pine.GSO.4.21.0109210931250.8014-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109220014130.11730-100000@uranus.planet.rcn.com.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Alexander Viro wrote:

>
>
> On 21 Sep 2001, Oystein Viggen wrote:
>
> > * [	David Chow]
> >
> > > The idea is orinigally from FiST, a stackable file system. But the FiST
> > > owner Erez seems given up to maintain the project. At the time I receive
> > > the code, it is so buggy, even unusable, lots of segmentation fault
> > > problems. I have debugging the fs for quite a while. Now it is useful in
> > > just use as a file system wrapper. It is useful in chroot environments
> > > and hardlinks aren't available. It wraps a directory and mount to
> > > another directory on tops of any filesystems.
> >
> > Is this not essentially what we already have with mount --bind in 2.4?
>
> Bindings can be used to get the same result, but underlying mechanics is
> different.  Wrapfs is not the most interesting application of FiST, so it's
> hardly a surprise...
>

I think you people didn't understand what is wrapfs, if is only a template
for FiST. The aim is to provide a properly maintained stackable template
under linux, and so that people can use FiST to develop their own
filesystem. Currently the wrapfs template is so buggy, I spend weeks to
fix all the bugs and even rewriting some of the code to make it more
efficient. This dosn't means --bind, it means it also fix up tons of FS'es
that is previously produced by using the old buggy FiST template, FiST is
good for developing new stackable file system, the current problem is that
the templates are buggy.... you got it??? If you know something is good
but it is not properly maintained, why not give it a hand and do all the
people a flavour?

regards,

David

