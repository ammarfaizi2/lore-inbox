Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268807AbUHaThZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268807AbUHaThZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUHaThP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:37:15 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59264 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268807AbUHaTc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:32:28 -0400
Message-Id: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
To: Pavel Machek <pavel@ucw.cz>
cc: David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Pavel Machek <pavel@ucw.cz> 
   of "Tue, 31 Aug 2004 10:21:44 +0200." <20040831082144.GA535@elf.ucw.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 31 Aug 2004 15:31:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> said:
> David Masover <ninja@slaphack.com> said:

[...]

> > Just want to extract the tar file?  Maybe something like
> > cat foo.tgz/gunzip
> > In which case (of course) foo.tgz/gunzip has exactly the same directory
> > contents as foo.tgz
> 
> Yes, that would work.
> 
> > In fact, for just about any syntax anyone could suggest, I can't really
> > see why you can't just replace all weird symbols with a slash and a
> > symbol.  Instead of
> > 	foo.tgz#utar
> > you have
> > 	foo.tgz/#/utar
> > Only difference is, some things which used to require special tools can
> > now be serviced by less than what's in busybox.
> 
> That would work, too. I do not get your comment about busybox.

You do need extra tools anyway, placing them in the kernel is cheating (and
absolutely pointless, IMHO).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
