Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277390AbRJJUIP>; Wed, 10 Oct 2001 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277391AbRJJUIF>; Wed, 10 Oct 2001 16:08:05 -0400
Received: from oe64.law9.hotmail.com ([64.4.8.199]:53254 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277390AbRJJUHu>;
	Wed, 10 Oct 2001 16:07:50 -0400
X-Originating-IP: [66.108.21.174]
From: "Concerned Programmer" <tkhoadfdsaf@hotmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alexander Viro" <viro@math.psu.edu>, "Keith Owens" <kaos@ocs.com.au>,
        "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <E15rNBu-0008To-00@the-village.bc.nu> <4058.1002737910@redhat.com>
Subject: Re: Tainted Modules Help Notices
Date: Wed, 10 Oct 2001 16:06:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE64YU5ts1Tjkw1BzCf0000708c@hotmail.com>
X-OriginalArrivalTime: 10 Oct 2001 20:08:16.0487 (UTC) FILETIME=[4C614770:01C151C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I was under the same impression about the module licensing tagging.  I
had read that it was suppose to be for maintainability (.i.e. source
available so kernel gods can debug) and not to enforce ideological
conformity.  Now I read that anything not licensed under the GPL, including
BSD or simply public domain source code, will taint my kernel and modprobe
complains about non-GPL stuff including parport_pc which apparently did not
have a license.  Should I expect a Linux kernel KGB to show up next?

    Furthermore I have to agree with the previous poster.  Any module could
easily lie to MODULE_LICENSE about its licensing terms and that would not
make it's source automatically "free" and GPLable so I am now wondering if
this tainting mechanism is of any use at all.

    Just out of curiosity do all of these license tags in the modules take
up any permanent kernel memory, especially in a heavily modularize system?

> I believe that statement is as true as the assertion that nobody, even in
> the Free World, can write GPL'd code which use the algorithms covered by
> the patent.
>
> Either way, I didn't think that a political stance against patents was the
> point of the kernel tainting code - I thought it was about
maintainability.
>
> >  The problem we have is that "BSD without advertisment" can be claimed
> > by almost any binary only module whose author doesnt include source or
> > let it out fo their company ever
>
> GPL can also be claimed by a module whose author doesn't publish either
the
> source or the binary, or who charges lots and lots of money for shipping
the
> binary and ships the source with it with a 'request' that the recipient
> doesn't then give it away for free.
>
> But if we're not going to allow BSD-licensed modules to be loaded without
> tainting the kernel, we shouldn't mark any of the code distributed with
the
> kernel as BSD-licensed - we should make it all "Dual BSD/GPL" instead.
>
> It might also be useful to have a 'Dual GPL/Other' option, for covering
the
> other randomly dual-licensed code (like JFFS2).

