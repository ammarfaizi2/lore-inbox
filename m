Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWERTbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWERTbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWERTbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:31:10 -0400
Received: from web26601.mail.ukl.yahoo.com ([217.146.176.51]:41828 "HELO
	web26601.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932135AbWERTbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:31:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tP08TsFXS4cvN/bOUtC34YgSCQYurLMCt6oS7K/Oz3yaIN7Y5tlBruvX7VjJXcE8b0ZUUfjGngIb6WYNhUdoEVH6VFkxvV9r60UWr4D8dw8crZ4eR6KSrTKFe39ZCnZwcqQHEKHAkL7w45ZdAKL/YjkY5emUpe9Z5IcIGkkQwZg=  ;
Message-ID: <20060518193108.23173.qmail@web26601.mail.ukl.yahoo.com>
Date: Thu, 18 May 2006 21:31:08 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: helge.hafting@aitel.hist.no, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <m2odxvdv2o.fsf@vador2.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Thierry Vignaud <tvignaud@mandriva.com> a écrit :

> linux cbon <linuxcbon@yahoo.fr> writes:
> 
> > Why dont we have "good" 3D support in X ?
> 
> no documentation how to program nvidia 3d chips?
> or for the very latest ati chips?
> or from the XYZ vendor?
> ....


What do you think about this :

http://marc.theaimsgroup.com/?l=openbsd-misc&m=114738577123893&w=2

But let me be clear -- the X developers are a bunch of
shameless vendor-loving lapdogs who sure are taking
their time at solving this > 10 year old problem! 
They spend way more time chasing the latest vendor
binary loaded device driver, than they do solving this
obvious
problem.  (Translation: They don't want to change how
X works, because it would break the vendor binary
drivers from ATI and NVIDIA.  That is part of what
happens when X developers get jobs at vendors).

They've had 10 years, and yet every year they get more
entrenched in the entirely insecure model of "gigantic
process running as root, which accesses registers like
mad".

This problem is ENTIRELY the X group's fault!  They
have failed us. Ten years ago they were laughing at
Microsoft for moving their video subsystem into their
kernel, but now the joke is on the X developers,
because what Microsoft did solved all these driver
security problems!

This is 100% an X server bug.  It is not a hardware
bug, and it is not an operating system bug.


and this

http://marc.theaimsgroup.com/?l=openbsd-misc&m=114233317926101&w=2

Some of our architectures use a tricky and horrid
thing to allow X to run.  This is due to modern PC
video card architecture containing a large quantity of
PURE EVIL.  To get around this evil the X developers
have done some rather expedient things, such as
directly accessing the cards via IO registers,
directly from userland.  It is hard to see how they
could have done other -- that is how much evil the
cards contain.


> "belong to the OS" != "belong in the kernel"
> and where do you put the boundary of the OS? most
> people don't say
> that the OS is only the kernel...

Dont play with words. You know I meant graphics do
belong to the kernel. I didnt mean graphics belong to
gnu tools.


> like if xorg wasn't trying to improve x11 status
> (slowly trying to
> isolate priviliged stuff, introducing xcb, ...)

See above.


> > What is your opinion ? 
> 
> stop troll^h^h^h^h^h thread?

If I am a troll, then who are Theo or Linus ?




Thanks


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
