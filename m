Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWDLGB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDLGB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWDLGB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:01:26 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:62398 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1750916AbWDLGBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:01:25 -0400
Date: Wed, 12 Apr 2006 08:01:22 +0200
From: David Weinehall <tao@acc.umu.se>
To: jdow <jdow@earthlink.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <20060412060122.GW23222@vasa.acc.umu.se>
Mail-Followup-To: jdow <jdow@earthlink.net>,
	Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
	Joshua Hudson <joshudson@gmail.com>,
	Ramakanth Gunuganti <rgunugan@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com> <20060411230642.GV23222@vasa.acc.umu.se> <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com> <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org> <004101c65df4$5eb71ce0$0225a8c0@Wednesday>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004101c65df4$5eb71ce0$0225a8c0@Wednesday>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 10:45:55PM -0700, jdow wrote:
> >On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
> >>Joshua Hudson wrote:
> >>> On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
> >>>> OK, simplified rules; if you follow them you should generally be OK:
> >>..
> >>>> 3. Userspace code that uses interfaces that was not exposed to 
> >>userspace
> >>>> before you change the kernel --> GPL (but don't do it; there's almost
> >>>> always a reason why an interface is not exported to userspace)
> >>>>
> >>>> 4. Userspace code that only uses existing interfaces --> choose
> >>>> license yourself (but of course, GPL would be nice...)
> >>
> >>Err.. there is ZERO difference between situations 3 and 4.
> >>Userspace code can be any license one wants, regardless of where
> >>or when or how the syscalls are added to the kernel.
> >
> >that is not so clear if the syscalls were added exclusively for this
> >application by the authors of the application....
> 
> Consider a book. The book is GPLed. I do not have to GPL my brain when
> I read the book.
> 
> I add some margin notes to the GPLed book. I still do not have to GPL
> my brain when I read the book.

This is possibly the worst comparison I've read in a long long time...

It's rather a case of:

Consider a book.  The book is GPLed.  You take add one chapter to the
book.  The resulting book needs to be GPLed.

Now, instead of adding to that book, you "export" parts of the book by
copying them into your book.  Your new book wouldn't work without the
copied parts.  Your resulting book needs to be GPLed.

Your "read the book"-case is only comparable to the case of building
a userspace binary for local use that only uses existing interfaces,
vs building one that uses exported private interfaces.  In both cases,
since you're not distributing your modified version, you're free to
do whatever you like.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
