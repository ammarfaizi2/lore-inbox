Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274828AbRIUUsj>; Fri, 21 Sep 2001 16:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274827AbRIUUsa>; Fri, 21 Sep 2001 16:48:30 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:52488 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274826AbRIUUsS>; Fri, 21 Sep 2001 16:48:18 -0400
X-Apparently-From: <kratkin@yahoo.com>
Date: Thu, 20 Sep 2001 16:15:55 +0400 (MSD)
From: <kratkin@yahoo.com>
X-X-Sender: <kratkin@niktar.egar.egartech.com>
To: David Chow <davidtl@rcn.com.hk>
cc: Alexander Viro <viro@math.psu.edu>, Oystein Viggen <oysteivi@tihlde.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Wrapfs a stackable file system
In-Reply-To: <Pine.LNX.4.33.0109220014130.11730-100000@uranus.planet.rcn.com.hk>
Message-ID: <Pine.LNX.4.31.0109201611210.220-100000@niktar.egar.egartech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some docs about stackable fs (aka wrapfs):
http://www.isi.edu/~johnh/WORK/ucla.html
and:
http://www.isi.edu/~johnh/PAPERS/index.html

On Sat, 22 Sep 2001, David Chow wrote:

> On Fri, 21 Sep 2001, Alexander Viro wrote:
>
> >
> >
> > On 21 Sep 2001, Oystein Viggen wrote:
> >
> > > * [	David Chow]
> > >
> > > > The idea is orinigally from FiST, a stackable file system. But the FiST
> > > > owner Erez seems given up to maintain the project. At the time I receive
> > > > the code, it is so buggy, even unusable, lots of segmentation fault
> > > > problems. I have debugging the fs for quite a while. Now it is useful in
> > > > just use as a file system wrapper. It is useful in chroot environments
> > > > and hardlinks aren't available. It wraps a directory and mount to
> > > > another directory on tops of any filesystems.
> > >
> > > Is this not essentially what we already have with mount --bind in 2.4?
> >
> > Bindings can be used to get the same result, but underlying mechanics is
> > different.  Wrapfs is not the most interesting application of FiST, so it's
> > hardly a surprise...
> >
>
> I think you people didn't understand what is wrapfs, if is only a template
> for FiST. The aim is to provide a properly maintained stackable template
> under linux, and so that people can use FiST to develop their own
> filesystem. Currently the wrapfs template is so buggy, I spend weeks to
> fix all the bugs and even rewriting some of the code to make it more
> efficient. This dosn't means --bind, it means it also fix up tons of FS'es
> that is previously produced by using the old buggy FiST template, FiST is
> good for developing new stackable file system, the current problem is that
> the templates are buggy.... you got it??? If you know something is good
> but it is not properly maintained, why not give it a hand and do all the
> people a flavour?
>
> regards,
>
> David
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

