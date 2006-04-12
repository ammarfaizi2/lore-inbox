Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWDLOvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWDLOvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWDLOvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:51:39 -0400
Received: from [4.79.56.4] ([4.79.56.4]:7816 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751191AbWDLOvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:51:38 -0400
Subject: Re: GPL issues
From: Arjan van de Ven <arjan@infradead.org>
To: jdow <jdow@earthlink.net>
Cc: Mark Lord <lkml@rtr.ca>, Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <004101c65df4$5eb71ce0$0225a8c0@Wednesday>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
	 <20060411230642.GV23222@vasa.acc.umu.se>
	 <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>
	 <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org>
	 <004101c65df4$5eb71ce0$0225a8c0@Wednesday>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 16:51:32 +0200
Message-Id: <1144853492.3091.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 22:45 -0700, jdow wrote:
> > On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
> >> Joshua Hudson wrote:
> >> > On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
> >> >> OK, simplified rules; if you follow them you should generally be OK:
> >> ..
> >> >> 3. Userspace code that uses interfaces that was not exposed to userspace
> >> >> before you change the kernel --> GPL (but don't do it; there's almost
> >> >> always a reason why an interface is not exported to userspace)
> >> >>
> >> >> 4. Userspace code that only uses existing interfaces --> choose
> >> >> license yourself (but of course, GPL would be nice...)
> >> 
> >> Err.. there is ZERO difference between situations 3 and 4.
> >> Userspace code can be any license one wants, regardless of where
> >> or when or how the syscalls are added to the kernel.
> > 
> > that is not so clear if the syscalls were added exclusively for this
> > application by the authors of the application....
> 
> Consider a book. The book is GPLed. I do not have to GPL my brain when
> I read the book.
> 
> I add some margin notes to the GPLed book. I still do not have to GPL
> my brain when I read the book.

wrong comparison

you have a book, book is gpl'd. You have another book with another plot.
THat other book doesn't need to be gpl'd.

you have a book, book is gpl'd. Your other book now requires the first
book to change it's plot so that the two books form a series. This is
where your lawyer will get nervous.

Think of it differently perhaps, and it's a question of "where is the
boundary of the work"

You can see the situation with the syscall change in 2 ways:

1) kernel + modification is a work
   userspace app is a separate work

or

2) kernel is a work
   userspace app and the kernel modification are together one work

in this 2nd case you have a GPL issue. The question is if your lawyer
can convince the judge that the second interpretation is unreasonable.
That may or may not be easy, depending on the exact nature of the
modification.


