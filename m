Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269681AbUICNOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269681AbUICNOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:14:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46794 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S269683AbUICNLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:11:52 -0400
Message-Id: <200409031309.i83D9EMg003329@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Chris Dukes <pakrat@www.uk.linux.org>, Spam <spam@tnonline.net>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Thu, 02 Sep 2004 23:37:19 EST." <4137F4FF.3070608@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 09:09:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> said:
> Chris Dukes wrote:
> | On Thu, Sep 02, 2004 at 08:28:20PM -0500, David Masover wrote:
> |
> |>So implement a plugin which knows how to talk to a userland program
> |>which knows about metadata.  The plugin controls access to file-type.
> |>
> |>Maybe there ought to be a general-purpose userland plugin interface?  So
> |>that the only things left in the kernel are things that have to be there
> |>for speed and/or sanity reasons?  (Things like cryptocompress and
> |>standard file/directory plugins.)
> |
> |
> | Ahem,
> | Wasn't this the goal of GNU HURD?

> The goal of GNU HURD was to take everything out of the kernel and make
> it entirely daemons.  That's a far cry from keeping a file-type database
> (historically the realm of file managers) out of the kernel.

Yep. Traditional microkernel.

[...]

> | I really think you should ask them why they haven't delivered
> | something useful, then come back to this thread.

> Honestly?  I think it's mostly got nothing to do with architecture.  I
> think it's mostly got to do with politics.  Most people would rather
> hack on Linux, which is already done, than try to develop HURD, which is
> something new.  Most people also enjoy working with Linus (or prefer
> Linus to the FSF).

Partly right. Hurd is _much_ older than Linux, and didn't start from
scratch (Mach was around, and worked). Yet I remember hearing "any day now"
for Hurd from 86 or 87... and as of now, AFAIU even the people hacking on
Hurd prefer Linux (because Linux does work, Hurd doesn't).

> I do not like how Linux is monolithic.  I do not like having to reboot
> to upgrade the kernel,

Tough luck. An upgrade of the core will _always_ mean rebooting. Plus you
can replace modules in Linux without a reboot.

>                        and I do not like having to run closed software
> (the nvidia drivers) in the kernel (as in, full privelages, can crash
> entire system, yadda yadda).

Me neither. But that is not exactly Linux' fault, binary drivers are quite
strongly discouraged.

>                               But Linux is the best we have.

By far.

> The HURD people have delivered at least something.  I think there's even
> a Debian/HURD distro.  Whether it's useful probably has to do with
> whether it's stable/fast, which isn't likely.  You hear of Linux news
> every day, you hear of HURD maybe once in a lifetime -- "Hey, HURD
> exists!"

It is still vaporware, some 20 years later.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
