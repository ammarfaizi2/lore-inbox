Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288167AbSACD1B>; Wed, 2 Jan 2002 22:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288165AbSACD0w>; Wed, 2 Jan 2002 22:26:52 -0500
Received: from ns.suse.de ([213.95.15.193]:59921 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288163AbSACD0l>;
	Wed, 2 Jan 2002 22:26:41 -0500
Date: Thu, 3 Jan 2002 04:26:40 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102220333.A26713@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> One of my background assumptions is that the older a machine is, the
> more likely it is that the person doing the config will have a clue about
> what they're doing.

Bzzzzt. See Greg Hennessy's post.
(Not that I'm implying he hasn't a clue, but he makes a good point)

> These days hardware is so cheap that only geeks try to cram Linux onto
> old systems

Bzzzzzt.
Linux is getting deployed in lots of small businesses running
mailservers/firewalls etc on old P90's and the likes. Not because
they're run by geeks, but because they're running on a low budget.

> Thus I'm not very worried about DMI read failing on older hardware.

It fails on newer hardware too. The Vaio I quoted is less than a year old.
The CyrixIII BIOS is less than 6 months old.

> My main objective is to make configuration painless on modern PCI-only
> hardware -- which is why I want to be able to tell when there are no
> ISA slots, so I can deep-six questions about ISA drivers.

Go down the DMI path, and get it right _sometimes_, or take a zero.
Getting it right sometimes is likely to do more harm than good.

> > o  The geek next door who wants to tinker and learn about the kernel.
> >    Said geek is going to learn a damn sight more currently than he will
> >    with a dumbed down pointy clicky "build me a kernel" button.
>
> Your "they must show willingness to suffer pain, otherwise they're not worthy"
> attitude is really showing here.

Crap. I'm implying that there should be a learning curve to everything
no matter how small it may be. You're trying to remove the curve
altogether.

> Yes. But *I* want Aunt Tilley to be able to download the latest kernel
> sources and build/install them herself, without ever feeling that the task
> is beyond her capabilities.

*shakes head*, ok I'm all done trying to argue this one.

> I believe we need to learn the discipline of useability and take it seriously.
> Because talk plus code is much more convincing than just talk, I'm trying
> to demonstrate this by coding.  But I'll talk about it too :-).

And write a book perchance ? SCNR  8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

