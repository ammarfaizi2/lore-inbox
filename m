Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSACCo1>; Wed, 2 Jan 2002 21:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288151AbSACCoR>; Wed, 2 Jan 2002 21:44:17 -0500
Received: from ns.suse.de ([213.95.15.193]:29967 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288150AbSACCoG>;
	Wed, 2 Jan 2002 21:44:06 -0500
Date: Thu, 3 Jan 2002 03:44:03 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102211038.C21788@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> > hardware), I think you're barking up the wrong tree with this
> > anyway.
> But at the least I could have logic that says: if you get a DMI
> readout and there are no ISA slots listed, *then* do useful deductions.

See other posting with examples of dramatic failures of
'slots in box, but dmi says none' and 'no slots, dmi says some'.
still think this is usable ? You're nuts.

> This is fine if all we want is to impress each other with our wizardliness.
> If, on the other hand, we are serious about world domination, it's an
> attitude that's got to go.  We have enough real technical problems to solve
> without surrounding Linux with a thicket of pseudo-problems.

You're solving a non-problem.
Some examples of target audience you're aiming for in your previous
mail were I believe..

o  The geek next door who wants to tinker and learn about the kernel.
   Said geek is going to learn a damn sight more currently than he will
   with a dumbed down pointy clicky "build me a kernel" button.

o  Aunt Tilley.
   Vendors already ship an array of kernels which should make it
   unnecessary for her to have to build a kernel.

If you still think world domination is going to appear by idiotproofing
the kernel build process, I think you're in for a surprise.
We have far bigger usability problems in userspace. The point is that
$newcomertolinux doesn't need to know what a kernel is, let alone
have to build one. They just see "Booting progress" "Log in" "Desktop".

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

