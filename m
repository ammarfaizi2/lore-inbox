Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVFWTaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVFWTaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVFWT3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:29:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13010 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262992AbVFWTZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:25:58 -0400
Message-Id: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Thu, 23 Jun 2005 09:11:16 EST." <42BAC304.2060802@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 23 Jun 2005 15:24:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 23 Jun 2005 15:24:58 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Hans Reiser wrote:
> > Jeff Garzik wrote:

[...]

> > You missed his point.  He is saying ext3 code should migrate towards
> > becoming reiser4 plugins, and reiser4 should be merged now so that the
> > migration can get started.

> Sort of.
> 
> I think ext3 would be nice as a reiser4 plugin.

What for? It works just fine as it stands, AFAICS.

>                                                 Not everyone will want
> to reformat at once, but as the reiser4 code matures and proves itself
> (even more than it already has),

I for one have seen mainly people with wild claims that it will make their
machines much faster, and coming back later asking how they can recover
their thrashed partitions...

>                                  the ext3 people may find themselves
> wanting some of the more generic optimizations.

They'll filch them in due time, don't worry.

> But, I don't think that will realistically happen at all.
> 
> Instead, what will probably happen is that once Reiser4 is in the
> mainstream kernel, it will become more popular and noticable.  Other
> FSes will take note.  ext3 people may decide they want
> file-as-directory,

That idea is even much older than Linux itself, and no other (Unix)
filesystem has implemented it. Ever. Wonder why...

>                    and vfat people may decide they want cryptocompress,

I'm sure they don't, because it is mostly for Windows and assorted devices
(pendrives, digital cameras, ...) compatibility.

> and so on.  In order to do this, they can work with Namesys to port
> whatever feature they need at the time to the standard VFS.

I'm sure they are grateful for the offer.

> Eventually, with all the features ported, we end up with a situation
> where there may be no meaningful difference between a filesystem and a
> low-level reiser4 plugin.

Could very well take decades, if ever.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
