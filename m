Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269695AbUICRbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269695AbUICRbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUICRap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:30:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38342 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S269669AbUICR3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:29:10 -0400
Message-Id: <200409031726.i83HQxJc008835@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Steve Bergman <steve@rueb.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Thu, 02 Sep 2004 23:35:34 MST." <413810B6.7020805@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 13:26:58 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> David Masover wrote:
> > The use of ext3 as a filesystem isn't cross-platform.  Every disk-write
> > is platform-specific!  We should all be using captive-ntfs instead!

> ;-)
> 
> All this stuff about how no filesystem should be allowed to have 
> semantic features others don't, it seems very Bolshevist to me.

Haven seen that. Just requests that _experimental_ features be prototyped
in ReiserFS, and _if_ they show they are worth the hassle, _then_ design a
nice VFS interface on them.

> Let Linux have an ecosystem with a diverse ecology of filesystems, and 
> the features that work will reproduce to other filesystems.  I thought 
> that was the Linus way?

It is.

> If not, why did I spend 10 years laying the storage layer groundwork for 
> semantic enhancements when I could have taken that job at Sun as 
> filesystems architect and made a lot more money?

Dunno. That _you_ choose to do this is no reason _others_ will have to take
the results over lock, stock and barrel. 

Linux' development works because there is a lot of "wasted" effort on
alternatives that don't pan out. Many don't ever leave the drawing board,
others (like the (now defunct) Xiafs, devfs, and volume management code)
went far, even got fully implemented, only to be scrapped later. It might
just be ReiserFS' fate too..

> I want to tinker.  Let me play in my sandbox, and if you don't like what 
> I do, don't imitate it.....  I think there are plenty of users who like 
> reiser4 though....

Go tinker and play. But don't aggravate non-ReiserFS-users, please. Come up
with solutions to the issues Al Viro and Linus raised.

> Linus, trying to outguess someone who has spent 2 decades studying 
> namespace design as to what will be useful to users is risky.

I'd guess LKML adds up to a few thousand years mulling over this, so this
isn't a great point.

>                                                                Look at 
> reiser4's performance, see if it obsoletes V3, and if it does then let 
> me play a bit.

I'd say it is a free world.

> Objecting on the grounds that it causes VFS bugs is reasonable, but I 
> answered those questions and you did not respond (I can resend if 
> asked).  If you really really don't like what we do to VFS, well, we can 
> confine ourselves to sys_reiser4(), but that is only a last resort from 
> my view.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
