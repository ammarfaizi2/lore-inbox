Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283759AbRK3SnL>; Fri, 30 Nov 2001 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283760AbRK3Smy>; Fri, 30 Nov 2001 13:42:54 -0500
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:36480 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S283762AbRK3Slq>; Fri, 30 Nov 2001 13:41:46 -0500
Message-ID: <012b01c179ce$313204b0$01010a0a@nestorflorez.local>
From: "Nestor Florez" <nestor.florez@worldnet.att.net>
To: <kplug-lpsg@kernel-panic.org>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        <kplug-list@kernel-panic.org>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <3C07CCCD.EA5E340A@randomlogic.com>
Subject: Re: Coding style - a non-issue
Date: Fri, 30 Nov 2001 10:38:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Book     : Code Complete
Author   : Steve McConnell
Publisher: Microsoft Press

Nestor :-)

----- Original Message -----
From: "Paul G. Allen" <pgallen@randomlogic.com>
To: "Linux kernel developer's mailing list" <linux-kernel@vger.kernel.org>;
<kplug-list@kernel-panic.org>; <kplug-lpsg@kernel-panic.org>
Sent: Friday, November 30, 2001 10:15 AM
Subject: Re: Coding style - a non-issue


> Peter Waltenberg wrote:
> >
> > The problem was solved years ago.
> >
> > "man indent"
> >
> > Someone who cares, come up with an indentrc for the kernel code, and get
it
> > into Documentation/CodingStyle
> > If the maintainers run all new code through indent with that indentrc
> > before checkin, the problem goes away.
> > The only one who'll incur any pain then is a code submitter who didn't
> > follow the rules. (Exactly the person we want to be in pain ;)).
> >
> > Then we can all get on with doing useful things.
> >
>
> IMEO, there is but one source as reference for coding style: A book by
> the name of "Code Complete". (Sorry, I can't remember the author and I
> no longer have a copy. Maybe my Brother will chime in here and fill in
> the blanks since he still has his copy.)
>
> Outside of that, every place I have worked as a programmer, with a team
> of programmers, had a style that was adhered to almost religiously. In
> many cases the style closely followed "Code Complete". In the case of
> the kernel, as Alan and others have mentioned, there IS a Linux kernel
> coding style.
>
> In 99% of the Linux code I have seen, the style does indeed "suck". Why?
> Consider a new coder coming in for any given task. S/he knows nothing
> about the kernel and needs to get up to speed quickly. S/he starts
> browsing the source - the ONLY definitive explanation of what it does
> and how it works - and finds:
>
>  - Single letter variable names that aren't simple loop counters and
> must ask "What the h*** are these for?"
>  - No function/file comment headers explaining what the purpose of the
> function/file is.
>  - Very few comments at all, which is not necessarily bad except...
>  - The code is not self documenting and without comments it takes an
> hour to figure out what function Foo() does.
>  - Opening curly braces at the end of a the first line of a large code
> block making it extremely difficult to find where the code block begins
> or ends.
>  - Short variable/function names that someone thinks is descriptive but
> really isn't.
>  - Inconsistent coding style from one file to the next.
>  - Other problems.
>
> After all, the kernel must be maintained by a number of people and those
> people will come and go. The only real way to keep bugs at a minimum,
> efficiency at a maximum, and the learning curve for new coders
> acceptable is consistent coding style and code that is easily
> maintained. The things I note above are not a means to that end. Sure,
> maybe Bob, the designer and coder of bobsdriver.o knows the code inside
> and out without need of a single comment or descriptive
> function/variable name, but what happens when Bob can no longer maintain
> it? It's 10,000 lines of code, the kernel is useless without it, it
> broke with kernel 2.6.0, and Joe, the new maintainer of bobsdriver.o, is
> having a hell of a time figuring out what the damn thing does.
>
> An extreme case? Maybe, but how many times does someone come in to
> development and have to spend more hours than necessary trying to figure
> out how things work (or are supposed to work) instead of actually
> writing useful code?
>
> PGA
> --
> Paul G. Allen
> UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
> Akamai Technologies, Inc.
> www.akamai.com

