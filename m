Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWGXSJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWGXSJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGXSJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:09:58 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60879 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932282AbWGXSJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:09:57 -0400
Message-Id: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
To: Mike Benoit <ipso@snappymail.ca>
cc: Matthias Andree <matthias.andree@gmx.de>, Hans Reiser <reiser@namesys.com>,
       lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion 
In-Reply-To: Message from Mike Benoit <ipso@snappymail.ca> 
   of "Mon, 24 Jul 2006 09:57:24 MST." <1153760245.5735.47.camel@ipso.snappymail.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 24 Jul 2006 14:06:56 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 24 Jul 2006 14:06:57 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Benoit <ipso@snappymail.ca> wrote:
> On Mon, 2006-07-24 at 12:25 +0200, Matthias Andree wrote:
> > On Mon, 24 Jul 2006, Hans Reiser wrote:
> > 
> > > >and that's the end
> > > >of the story for me. There's nothing wrong about focusing on newer code,
> > > >but the old code needs to be cared for, too, to fix remaining issues
> > > >such as the "can only have N files with the same hash value". 
> > >
> > > Requires a disk format change, in a filesystem without plugins, to fix it.
> > You see, I don't care a iota about "plugins" or other implementation details.
> > 
> > The bottom line is reiserfs 3.6 imposes practial limits that ext3fs
> > doesn't impose and that's reason enough for an administrator not to
> > install reiserfs 3.6. Sorry.

> And EXT3 imposes practical limits that ReiserFS doesn't as well. The big
> one being a fixed number of inodes that can't be adjusted on the fly,

Right. Plan ahead.

> which was reason enough for me to not use EXT3 and use ReiserFS
> instead. 

I don't see this following in any way.

> Do you consider the EXT3 developers to have "abandoned" it because they
> haven't fixed this issue? I don't, I just think of it as using the right
> tool for the job.

Dangerous parallel, that one...

> I've been bitten by running out of inodes on several occasions,

Me too. It was rather painful each time, but fixable (and in hindsight,
dumb user (setup) error).

>                                                                 and by
> switching to ReiserFS it saved one company I worked for over $250,000
> because they didn't need to buy a totally new piece of software.

How can a filesystem (which by basic requirements and design is almost
transparent to applications) make such a difference?!

> I haven't been able to use EXT3 on a backup server for the last ~5 years
> due to inode limitations.

See comment above. Read mke2fs(8) with care.

>                           Instead, ReiserFS has been filling that spot
> like a champ. 

Nice for you.

> The bottom line is that every file system imposes some sort of limits
> that bite someone.

Mostly that infinite disks are hard to come by ;-)

>                    In your case it sounds like EXT3 limits weren't an
> issue for you, in my case they were.

I'd suspect the limits you ran into weren't exactly in ext3.

>                                      Thats life. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
