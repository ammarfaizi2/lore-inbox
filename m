Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWENR4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWENR4h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWENR4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:56:36 -0400
Received: from xenotime.net ([66.160.160.81]:26323 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751351AbWENR4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:56:35 -0400
Date: Sun, 14 May 2006 10:59:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Cleanups to Doc*/SubmittingPatches
Message-Id: <20060514105902.5f286271.rdunlap@xenotime.net>
In-Reply-To: <20060514172330.GH2438@elf.ucw.cz>
References: <20060514143037.GA2886@elf.ucw.cz>
	<20060514101254.f731daf1.rdunlap@xenotime.net>
	<20060514172330.GH2438@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2006 19:23:31 +0200 Pavel Machek wrote:

> Hi!
> 
> > > This cleans up Submitting patches a bit. Missing/inconsistent full
> > > stops, mostly.
> > 
> > Incomplete sentences (fragments) don't need full stops, but they
> > should be consistent.
> > 
> > > diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> > > index c2c85bc..07b87ce 100644
> > > --- a/Documentation/SubmittingPatches
> > > +++ b/Documentation/SubmittingPatches
> > > @@ -173,17 +173,17 @@ copy the maintainer when you change thei
> > >  For small patches you may want to CC the Trivial Patch Monkey
> > >  trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
> > >  patches. Trivial patches must qualify for one of the following rules:
> > > - Spelling fixes in documentation
> > > + Spelling fixes in documentation.
> > >   Spelling fixes which could break grep(1).
> > 
> > I would just remove that '.' above and skip the rest of the
> > changes in this section.
> 
> Does this look better? (Sorry, english is my 2nd language).

Yes, thanks.  You (and the rest of the world) do a better job
of communicating in English than many of us could do in another
language.

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c2c85bc..6f873e5 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -174,15 +174,15 @@ For small patches you may want to CC the
>  trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
>  patches. Trivial patches must qualify for one of the following rules:
>   Spelling fixes in documentation
> - Spelling fixes which could break grep(1).
> + Spelling fixes which could break grep(1)
>   Warning fixes (cluttering with useless warnings is bad)
>   Compilation fixes (only if they are actually correct)
>   Runtime fixes (only if they actually fix things)
> - Removing use of deprecated functions/macros (eg. check_region).
> + Removing use of deprecated functions/macros (eg. check_region)
>   Contact detail and documentation fixes
>   Non-portable code replaced by portable code (even in arch-specific,
>   since people copy, as long as it's trivial)
> - Any fix by the author/maintainer of the file. (ie. patch monkey
> + Any fix by the author/maintainer of the file (ie. patch monkey
>   in re-transmission mode)
>  URL: <http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/>
>  
> @@ -246,13 +246,13 @@ updated change.
>  It is quite common for Linus to "drop" your patch without comment.
>  That's the nature of the system.  If he drops your patch, it could be
>  due to
> -* Your patch did not apply cleanly to the latest kernel version
> +* Your patch did not apply cleanly to the latest kernel version.
>  * Your patch was not sufficiently discussed on linux-kernel.
> -* A style issue (see section 2),
> -* An e-mail formatting issue (re-read this section)
> -* A technical problem with your change
> -* He gets tons of e-mail, and yours got lost in the shuffle
> -* You are being annoying (See Figure 1)
> +* A style issue (see section 2).
> +* An e-mail formatting issue (re-read this section).
> +* A technical problem with your change.
> +* He gets tons of e-mail, and yours got lost in the shuffle.
> +* You are being annoying.
>  
>  When in doubt, solicit comments on linux-kernel mailing list.
>  
> @@ -475,22 +475,22 @@ SECTION 3 - REFERENCES
>  Andrew Morton, "The perfect patch" (tpp).
>    <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
>  
> -Jeff Garzik, "Linux kernel patch submission format."
> +Jeff Garzik, "Linux kernel patch submission format".
>    <http://linux.yyz.us/patch-format.html>
>  
> -Greg Kroah-Hartman "How to piss off a kernel subsystem maintainer".
> +Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
>    <http://www.kroah.com/log/2005/03/31/>
>    <http://www.kroah.com/log/2005/07/08/>
>    <http://www.kroah.com/log/2005/10/19/>
>    <http://www.kroah.com/log/2006/01/11/>
>  
> -NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!.
> +NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
>    <http://marc.theaimsgroup.com/?l=linux-kernel&m=112112749912944&w=2>
>  
> -Kernel Documentation/CodingStyle
> +Kernel Documentation/CodingStyle:
>    <http://sosdg.org/~coywolf/lxr/source/Documentation/CodingStyle>
>  
> -Linus Torvald's mail on the canonical patch format:
> +Linus Torvalds's mail on the canonical patch format:
>    <http://lkml.org/lkml/2005/4/7/183>
>  --

---
~Randy
