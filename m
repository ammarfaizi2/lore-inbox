Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVGMCmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVGMCmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 22:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVGMCmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 22:42:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:20450 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262914AbVGMCmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 22:42:21 -0400
Message-Id: <200507130209.j6D29TB1004476@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Hans Reiser <reiser@namesys.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Stefan Smietanowski <stesmi@stesmi.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Tue, 12 Jul 2005 18:22:38 EST." <42D450BE.70404@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 12 Jul 2005 22:09:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Hans Reiser wrote:
> > Horst von Brand wrote:
> >>Hans Reiser <reiser@namesys.com> wrote:
> >>>Stefan Smietanowski wrote:

[...]

> > Better to spend one's mind looking for bugs instead of this issue.....
> 
> .....if bugs were seen as such a big deal.

> I think it's far easier to get into the kernel with something
> ludicrously buggy than something which actually changes fundamental
> behavior.


Wonder why....

[Fixing bugs in the $FOO driver or the $BAR filesystem is /easy/, fixing
 bugs in "fundamental behaviour changes" is /extremely hard/.]

>            That is, you can put in an FS which actually corrupts data
> (such as the old NTFS write support), so long as it doesn't break POSIX,
> or cause other weird restrictions like "No files named 'metas'"

Because that kind of problems are isolated. If you introduce a change that
affects /all/ filesystems, and that change later on has unfixable bugs, or
fundamental design issues, it is /a lot/ of work.

> Now, if we can decide that we don't care about being in the vanilla
> kernel, then we can just call it ".metas" or "lost+found" or whatever
> and get to work on bug fixes and other much-needed features such as a
> repacker.

Great!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
