Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWDLG0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWDLG0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWDLG0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:26:46 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:50613 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750905AbWDLG0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:26:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=k51xATC1gb/A6Y1RzJa9Sp+WawfMyoqa9S5ijdGXZuSAGzH/GBGEjd4fZX2wq3Xm;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <004d01c65dfa$0e2bda80$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "David Weinehall" <tao@acc.umu.se>
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Mark Lord" <lkml@rtr.ca>,
       "Joshua Hudson" <joshudson@gmail.com>,
       "Ramakanth Gunuganti" <rgunugan@yahoo.com>,
       <linux-kernel@vger.kernel.org>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com> <20060411230642.GV23222@vasa.acc.umu.se> <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com> <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org> <004101c65df4$5eb71ce0$0225a8c0@Wednesday> <20060412060122.GW23222@vasa.acc.umu.se>
Subject: Re: GPL issues
Date: Tue, 11 Apr 2006 23:26:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112070bd049b34611176eb7bce5c77cb9c123ca473d225a0f487350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.162.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Weinehall" <tao@acc.umu.se>
> On Tue, Apr 11, 2006 at 10:45:55PM -0700, jdow wrote:
>> >On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
>> >>Joshua Hudson wrote:
>> >>> On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
>> >>>> OK, simplified rules; if you follow them you should generally be OK:
>> >>..
>> >>>> 3. Userspace code that uses interfaces that was not exposed to 
>> >>userspace
>> >>>> before you change the kernel --> GPL (but don't do it; there's almost
>> >>>> always a reason why an interface is not exported to userspace)
>> >>>>
>> >>>> 4. Userspace code that only uses existing interfaces --> choose
>> >>>> license yourself (but of course, GPL would be nice...)
>> >>
>> >>Err.. there is ZERO difference between situations 3 and 4.
>> >>Userspace code can be any license one wants, regardless of where
>> >>or when or how the syscalls are added to the kernel.
>> >
>> >that is not so clear if the syscalls were added exclusively for this
>> >application by the authors of the application....
>> 
>> Consider a book. The book is GPLed. I do not have to GPL my brain when
>> I read the book.
>> 
>> I add some margin notes to the GPLed book. I still do not have to GPL
>> my brain when I read the book.
> 
> This is possibly the worst comparison I've read in a long long time...
> 
> It's rather a case of:
> 
> Consider a book.  The book is GPLed.  You take add one chapter to the
> book.  The resulting book needs to be GPLed.

I am with you this far.

> Now, instead of adding to that book, you "export" parts of the book by
> copying them into your book.  Your new book wouldn't work without the
> copied parts.  Your resulting book needs to be GPLed.

Nothing is exported except to the reader's brain aka user space. It
is not exported to a new book.

Exporting a new interface is equivalent to making the marginal notes.

You can still READ the book without GPLing your brain or your
application. You can make additional temporary marginal notes,
place data into the kernel which causes the kernel to disgorge
some data.

> Your "read the book"-case is only comparable to the case of building
> a userspace binary for local use that only uses existing interfaces,
> vs building one that uses exported private interfaces.  In both cases,
> since you're not distributing your modified version, you're free to
> do whatever you like.

Either you cannot have a non-GPL program on the kernel OR you can. It
makes no difference if the kernel is modified (the modification is GPL)
or the kernel is not modified. The modified kernel must be distributed
as source if requested. The application does not unless EVERY application
must be distributed with source.

There is apparently no argument with regards to applications that are
not GPL running on LINUX. Therefore there should be no argument with
an application that uses a newly exported API being GPLed.

If you are considering the potential case that the modification is made
to the kernel and then the source for that modification is also used in
user space in an application requiring the application to be GPLed then
you must first prove it was done in that order rather than the other order.
Code can also be released dual licensed. GPL for the kernel and private
for the user space, if it is done so by the owner or creator of the code
in question. Anything else is absurd on its face.

{^_^}   Joanne Dow
