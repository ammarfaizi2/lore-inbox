Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154055-19608>; Thu, 21 Jan 1999 23:00:26 -0500
Received: by vger.rutgers.edu id <154141-19608>; Thu, 21 Jan 1999 20:35:52 -0500
Received: from hera.ecs.csus.edu ([130.86.71.150]:4974 "EHLO hera.ecs.csus.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154571-19608>; Thu, 21 Jan 1999 17:52:58 -0500
Date: Thu, 21 Jan 1999 14:57:28 -0800 (PST)
From: "Jon M. Taylor" <taylorj@ecs.csus.edu>
To: Steven Roberts <strobert@ata-sd.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: User vs. Kernel (was: To be smug, or not to be smug, that is , the question)
In-Reply-To: <36A755E0.D893343D@ata-sd.com>
Message-ID: <Pine.HPP.3.91.990121142146.308A-100000@gaia.ecs.csus.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 21 Jan 1999, Steven Roberts wrote:

> "Albert D. Cahalan" wrote:
>
> > If someone with great vision and design skills wants to create a
> > new API for Linux, we should seriously consider such a proposal.

	That is IMHO a bad idea.  Linux, because it follows the
traditional Unix monolithic kernel model, is already so obsolete that it
really isn't worth putting serious time into incompatible API
improvements.  Its value right now is that it is a free, well-written and
POSIX-compatible open source Unix clone.  Please leave it as such.  Just
treat Linux as what it is: a legacy-compatible *interim* OS that provides
a nice, mostly-stable and well-known environment in which to develop
device drivers and OS guts (and apps, GUIs etc too).

	Soon, probably within a year or two, a decent, open-source next
generation OS like Hurd (Microkernel), FluxOS (polymorphic virtual
machines/nested processes), Dolphin (exokernel), The Cache Kernel, or
another NGOS will be developed to the point where it can step in and
cannibalize the guts out of Linux to produce a fully-functional NGOS which
is suitable for mainstream use.  With the Univerity of Utah OSKit having
been released, this process is well underway and accelerating rapidly.  At
that point, then, we all can dump 25+ years of accumulated Unix API
brokenness and move on to a clean, modern, well-designed OS.

	Linux will then exist only as some sort of NGOS legacy
compatibility wrapper, like WINE, and the real Linux can gracefully fade
away into history, its "springboard" role having run its course.  This is 
the natural way of things.  If you want to "fix" Unix/Linux, do it right 
and rework everything ground-up from first principles.  Just MHO of 
course.

Jon

---
'Cloning and the reprogramming of DNA is the first serious step in 
becoming one with God.'
	- Scientist G. Richard Seed


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
