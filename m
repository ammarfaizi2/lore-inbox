Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283765AbRK3S5B>; Fri, 30 Nov 2001 13:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRK3S46>; Fri, 30 Nov 2001 13:56:58 -0500
Received: from mail303.mail.bellsouth.net ([205.152.58.163]:50326 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280960AbRK3S4r>; Fri, 30 Nov 2001 13:56:47 -0500
Message-ID: <3C07D669.6C234598@mandrakesoft.com>
Date: Fri, 30 Nov 2001 13:56:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul G. Allen" <pgallen@randomlogic.com>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <3C07CCCD.EA5E340A@randomlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul G. Allen" wrote:
> IMEO, there is but one source as reference for coding style: A book by
> the name of "Code Complete". (Sorry, I can't remember the author and I
> no longer have a copy. Maybe my Brother will chime in here and fill in
> the blanks since he still has his copy.)

Hungarian notation???

That was developed by programmers with apparently no skill to
see/remember how a variable is defined.  IMHO in the Linux community
it's widely considered one of the worst coding styles possible.


> Outside of that, every place I have worked as a programmer, with a team
> of programmers, had a style that was adhered to almost religiously.

yes

> In 99% of the Linux code I have seen, the style does indeed "suck". Why?
> Consider a new coder coming in for any given task. S/he knows nothing
> about the kernel and needs to get up to speed quickly. S/he starts
> browsing the source - the ONLY definitive explanation of what it does
> and how it works - and finds:

99% is far and above the level of suck defined by most :)


>  - Single letter variable names that aren't simple loop counters and
> must ask "What the h*** are these for?"
>  - No function/file comment headers explaining what the purpose of the
> function/file is.
>  - Very few comments at all, which is not necessarily bad except...
>  - The code is not self documenting and without comments it takes an
> hour to figure out what function Foo() does.

We could definitely use a ton more comments... patches accepted.


>  - Opening curly braces at the end of a the first line of a large code
> block making it extremely difficult to find where the code block begins
> or ends.

use a decent editor


>  - Short variable/function names that someone thinks is descriptive but
> really isn't.

not all variable names need their purpose obvious to complete newbies. 
sometimes it takes time to understand the code's purpose, in which case
the variable names become incredibly descriptive.


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

yes

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

