Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUJZI1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUJZI1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUJZI1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:27:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10254 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262176AbUJZI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:27:24 -0400
Date: Tue, 26 Oct 2004 03:07:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>, espenfjo@gmail.com
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041026010748.GD30599@stusta.de>
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com> <20041022225703.GJ19761@alpha.home.local> <20041023014004.GG22558@stusta.de> <20041023050439.GA11484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20041023050439.GA11484@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, Oct 22, 2004 at 10:04:39PM -0700, Greg KH wrote:
> On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
> > On Sat, Oct 23, 2004 at 12:57:03AM +0200, Willy Tarreau wrote:
> > > On Fri, Oct 22, 2004 at 11:52:50PM +0200, Espen Fjellv?r Olsen wrote:
> > >...
> > > > A 2.7 should be created where all new experimental stuff is merged
> > > > into it, and where people could begin to think new again.
> > > 
> > > This could be true if the release cycle was shorter. But once 2.7 comes
> > > out, many developpers will only focus on their development and not on
> > > stabilizing 2.6 as much as today.
> > 
> > 2.6.9 -> 2.6.10-rc1:
> > - 4 days
> > - > 15 MB patches
> > 
> > It's a bit optimistic to call this amount of change "stabilizing".
> > 
> > 2.6 is corrently more a development kernel than a stable kernel.
> > 
> > The last bug I observed personally was the problem with suspending when 
> > using CONFIG_REGPARM=y together with Roland's waitid patch which was 
> > added in 2.6.9-rc2. If I'd used 2.6.9 with the same .config as 2.6.8.1, 
> > this was simple one more bug...
> > 
> > IMHO Andrew+Linus should open a short-living 2.7 tree soon and Andrew 
> > (or someone else) should maintain a 2.6 tree with less changes (like 
> > Marcelo did and does with 2.4).
> 
> I don't ever want to plug anything I've written, but please see the
> current issue of Linux Journal with an article explaining how this is
> all working, why we are doing this, and how the hell we can keep sane
> this way.  I've also got slides on my website from the talk I've given
> about this topic at OLS, OSCON, and SUCON about this topic.
>...

I looked at your slides, but to be honest, I'm still not convinced.

The Andrew+Linus model with -mm works pretty well.
Why shouldn't it also work in 2.7 removing all the past problems with 
overly long release cycles between two stable series?

If it could be achieved to release 2.8 half a year after 2.7 was 
started, this should be short enough for distributions etc. for not 
having to backport too much while giving the benefits of putting the 
patch pressure away from 2.6 making it more stable.

> thanks,
> 
> greg k-h

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBfaNkmfzqmE8StAARAmAvAJ9kav1shMitTz201gO+hyo4UCt3ygCfRQ70
weQeqRyMgS/r8befY8qa5Uk=
=tm91
-----END PGP SIGNATURE-----
