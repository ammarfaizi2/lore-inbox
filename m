Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268407AbUIBPeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbUIBPeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 11:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268413AbUIBPeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 11:34:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:14758 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268407AbUIBPeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 11:34:08 -0400
Message-Id: <200409021532.i82FW8Si005822@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Thu, 02 Sep 2004 01:58:30 MST." <4136E0B6.4000705@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 02 Sep 2004 11:32:08 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> Linus Torvalds wrote:

> > But _my_ point is, no user program is going to take _advantage_ of
> >anything that only one filesystem on one system offers.

> Apple does not have this problem....

... because Apple customers are a captive lot...

> and yes, the apps will take advantage of it, which is different from 
> depending on it.  If you use the wrong fs you will lose some of the 
> features of the app.

... which is undesirable to say the very least for cross-platform Unix
(even worse, Unix + Windows) applications, so applications won't ever use
it (until Linux + super-duper filesystem is more than, say, 80% of the
market). I.e., it won't happen soon enough for this to make sense right
now. Perhaps in 13 more years...

> For 30 years nothing much has happened in Unix filesystem semantics 
> because of sheer cowardice

Careful threading there... calling respected people names without any proof
isn't exactly great PR.

>                            (excepting Clearcase, which priced itself 
> into a niche market).  It is 25 years past time for someone to change
> things.

Your opinion. Some people disagree.

>          That someone will have first mover advantage, and the more
> little semantic features possessed the more lure there will be to use it
> which will increase market share which will lure more apps into depending
> on it and in a few years the other filesystems will (deservedly) have
> only a small market share because the apps won't all work on them.

You seem to be blinded by the "success effect": You only ever see the ones
who succeed, you don't see the masses who tried to be "first movers" and
failed utterly. 

> Besides, there are enhancements which are simply compelling.  You can 
> write a dramatically better performance version control system with a 
> much simpler design if the FS is atomic.

Iff the performance of the FS is better _at doing what the system wants
than the system itself_. That the CVS is simpler/faster is no use
whatsoever if the underlying OS is more complex/slower. Besides, what is
ideal for CVS isn't necesarily good for word processing or databases, and
probably irrelevant or at least overkill for a lot of other applications,
which all end up paying the costs.

Concentrate on giving what _most_ applications want, make it possible for
applications with weird requirements to do their job.

>                                             Our transaction manager 
> first draft was written by a version control guy, and he would probably 
> be happy to tell you how  lack of atomicity other than rename makes 
> version control software design hideous.

Right. But it doesn't make the design of text editing, or word processing,
or mail handling, or... hideous, does it? Having a strong background in an
area does put blinds on one's eyes.

> We have the performance lead.

I recently saw (preliminary) numbers directly contradicting this somewhere.

>                                By next year we will be stable enough for 
> mission critical servers, and then we start the serious semantic 
> enhancements.

By which the performance lead (if any) will do down the drain. There ain't
no free lunch.

> If you don't embrace progress, then you doom Linux to following behind, 
> because the guys at Apple are pretty aggressive now that Jobs is back, 
> and they WILL change the semantics, and they will do so in compelling 
> ways, and Linux will be reduced to aping them when it should be leading 
> them.

Why on earth should Linux copy a niche system? By now Linux's marketshare
is _much_ larger than Apple's... I'd say it is the other way around: Apple
tries desperately to differentiate itself from MSFT (and traditional Unix +
Linux) in order not to dissapear (and keep their grip on their users). If
they are doing it right, only time will tell. But that is no reason to
screw up Linux' strengths.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
