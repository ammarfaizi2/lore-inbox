Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVFXNNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVFXNNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVFXNLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:11:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62908 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262470AbVFXNJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:09:56 -0400
Message-Id: <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Thu, 23 Jun 2005 22:17:06 EST." <42BB7B32.4010100@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 23 Jun 2005 23:34:50 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 24 Jun 2005 09:08:52 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Alan Cox wrote:
> > On Iau, 2005-06-23 at 23:04, David Masover wrote:

[...]

> >>>What for? It works just fine as it stands, AFAICS.

> >>So does DOS.  Do you use DOS?  I don't even use DOS to run DOS programs.

> > False argument. So does the pen, so do hinges on doors. Do you still
> > have hinges on your doors - probably.

> Indeed.  Because there's nothing better -- not because I "like it the
> way it is".

There being nothing better means nobody has ever been able to come up with
a better way. Most of the time at least.

> >>"Ain't broke" is the battle cry of stagnation.

> > Its also the battle cry of everyone over the age of 20 who also has a
> > real job to do 8)

> You caught me.  I'm not over 20.  But I have a real job, with a company
> that understands the difference between "ain't broke" and "works well".

"Doesn't work well" /is/ the definition of "broken". Modulo how irritating
the "not working well" is...

> >>But, there are some things Reiser does better and faster than ext3, even
> >>if you don't count file-as-directory and other toys.  There's nothing
> >>ext3 does better than Reiser, unless you count the compatibility with
> >>random bootloaders and low-level tools.

> > Certainly compared with reiser3 you've missed a few out including
> > resilience to disk errors (nearly nil on reiser3), and SMP scaling.

> Actually, I was talking about reiser4.  And Hans corrected me on that...
> 
> Although resilience to disk errors isn't a design decision.  That's what
> SMART and new hard drives are for.  And if you're stubborn enough to
> keep the same FS around, there's dm-bbr.

> I think Hans (or someone) decided that when hardware stops working, it's
> not the job of the FS to compensate, it's the job of lower layers, or
> better, the job of the admin to replace the disk and restore from
> backups.

Handling other people's data this way is just reckless irresponsibility.
Sure, you can get high performance if you just forego some of your basic
responsibilities.

> >>You know how many I've had thrashed on Reiser4?  Two.  The first one was
> >>with a VERY early alpha/beta, and the second one was when I dropped a
> >>laptop and the disk failed.

> > Entirely or bad blocks ? The latter should have a minimal cost on a well
> > designed fs.

> I was able to recover from bad blocks, though of course no Reiser that I
> know of has had bad block relocation built in...  But I got all my files
> off of it, fortunately.

And if the bad blocks had been on files? 

[...]

> > In which case the features belong in the VFS as all those with
> > experience and kernel contributions have been arguing.

> No one's arguing that.  What we're arguing is that there does seem to be
> a bit of prejudice when fuck-me-with-a-chainsaw and YOU ARE A FOOL FOR
> ENABLING THIS all got in, and with at least one of those, there doesn't
> seem to be any intention of changing it -- all of that, and even with an
> expressed intention to fix the aesthetical problems with Reiser4 later,
> we can't get the working version in now.
> 
> More infuriatingly, I, at least, have a distinct feeling that once all
> the issues are fixed, an entirely different crowd of benevolent
> dictators will come around and say that we can't get in because we
> change the VFS.  At least some people on this list have said things to
> that effect.

The dictators here have changed over time, sure. Their general attitude has
been the same all the way through, since the list started. And you might
not like it that way, but I am sure Linux is of the current high quality
exactly because any core code that gets into the kernel (and a new
filesystem that wants to be central is clearly of this kind) is checked by
multiple people with (sometimes widely) diverging backgrounds, interests,
and views. Linus himself has stated more than once that his principal job
isn't to integrate code into the kernel, but leaving stuff out.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513


