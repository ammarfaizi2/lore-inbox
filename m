Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUIFSQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUIFSQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUIFSQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:16:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12201 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268436AbUIFSQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:16:27 -0400
Message-Id: <200409061814.i86IEcPJ005086@laptop11.inf.utfsm.cl>
To: Spam <spam@tnonline.net>
cc: Tonnerre <tonnerre@thundrix.ch>, Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Sun, 05 Sep 2004 14:30:12 +0200." <1819110960.20040905143012@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 06 Sep 2004 14:14:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:

[...]

>   The problem with the userspace library is standardization. What
>   would be needed is a userspace library that has a extensible plugin
>   interface that is standardized. Otherwise we would need lots of
>   different libraries, and I seriously doubt that 1) this will happen
>   and 2) we get all Linux programs to be patched to use it.

What is the difference with a kernel implementation? Not by being in-kernel
will it make all the incompatible ways of doing this magically vanish, and
give outstanding performance. Plus handling and maintaining the in-kernel
stuff is _much_ harder than userspace libraries.

I'd go the other way around: Get userspace to agree on a common framework,
make it work in userspace; if (extensive, hopefully) experience shows that
a pure userspace solution has issues that can't be solved except by kernel
assistance, so be it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
