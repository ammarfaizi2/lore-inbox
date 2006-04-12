Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWDLJN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDLJN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDLJN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:13:28 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:61654 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750934AbWDLJN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:13:28 -0400
Message-ID: <443CC4AD.4000608@stesmi.com>
Date: Wed, 12 Apr 2006 11:13:17 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: jdow <jdow@earthlink.net>, Arjan van de Ven <arjan@infradead.org>,
       Mark Lord <lkml@rtr.ca>, Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com> <20060411230642.GV23222@vasa.acc.umu.se> <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com> <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org> <004101c65df4$5eb71ce0$0225a8c0@Wednesday> <20060412060122.GW23222@vasa.acc.umu.se>
In-Reply-To: <20060412060122.GW23222@vasa.acc.umu.se>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig7A45622F188FD22C240D4E0B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A45622F188FD22C240D4E0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David Weinehall wrote:
> On Tue, Apr 11, 2006 at 10:45:55PM -0700, jdow wrote:
> 
>>>On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
>>>
>>>>Joshua Hudson wrote:
>>>>
>>>>>On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
>>>>>
>>>>>>OK, simplified rules; if you follow them you should generally be OK:
>>>>
>>>>..
>>>>
>>>>>>3. Userspace code that uses interfaces that was not exposed to 
>>>>
>>>>userspace
>>>>
>>>>>>before you change the kernel --> GPL (but don't do it; there's almost
>>>>>>always a reason why an interface is not exported to userspace)
>>>>>>
>>>>>>4. Userspace code that only uses existing interfaces --> choose
>>>>>>license yourself (but of course, GPL would be nice...)
>>>>
>>>>Err.. there is ZERO difference between situations 3 and 4.
>>>>Userspace code can be any license one wants, regardless of where
>>>>or when or how the syscalls are added to the kernel.
>>>
>>>that is not so clear if the syscalls were added exclusively for this
>>>application by the authors of the application....
>>
>>Consider a book. The book is GPLed. I do not have to GPL my brain when
>>I read the book.
>>
>>I add some margin notes to the GPLed book. I still do not have to GPL
>>my brain when I read the book.
> 
> 
> This is possibly the worst comparison I've read in a long long time...
> 
> It's rather a case of:
> 
> Consider a book.  The book is GPLed.  You take add one chapter to the
> book.  The resulting book needs to be GPLed.
> 
> Now, instead of adding to that book, you "export" parts of the book by
> copying them into your book.  Your new book wouldn't work without the
> copied parts.  Your resulting book needs to be GPLed.
> 
> Your "read the book"-case is only comparable to the case of building
> a userspace binary for local use that only uses existing interfaces,
> vs building one that uses exported private interfaces.  In both cases,
> since you're not distributing your modified version, you're free to
> do whatever you like.
> 
> 
> Regards: David

IANAL But I don't think that makes any difference at all.

The INTERACTION between syscalls and userspace is not a topic for
discussion really. Otherwise we'd have to put the boundary at
"syscalls that the Linux Gurus added" vs "syscalls someone else added
cause they thought they were neat".

NONE of the ones in the "neat" category are ever to be used ever by
ANY non-GPL program.

That is what it boils down to. I add a syscall to the kernel, you don't
like it? Tough, it's GPL so I can distribute it, etc etc.

A program emerges that uses that syscall? You don't like that ?
Equally tough. It doesn't matter if I wrote both parts or just one,
we're not looking at INTENT here. Either programs can be non-GPL
or they can't.

Btw, no I'm not jumping at anyone here, I am just trying to show
a point.

// Stefan

--------------enig7A45622F188FD22C240D4E0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEPMSxBrn2kJu9P78RA2KKAKCqq3bvGWojLlFIrPvdFfjih+aAuQCbBpkV
9dygz4OoHHKsSoWKrcnDcHA=
=glSc
-----END PGP SIGNATURE-----

--------------enig7A45622F188FD22C240D4E0B--
