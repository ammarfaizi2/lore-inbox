Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129058AbRAaVyz>; Wed, 31 Jan 2001 16:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129038AbRAaVyp>; Wed, 31 Jan 2001 16:54:45 -0500
Received: from mdmgrp1-167.accesstoledo.net ([207.43.106.167]:4356 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129050AbRAaVyf>;
	Wed, 31 Jan 2001 16:54:35 -0500
Date: Tue, 30 Jan 2001 16:53:42 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ACPI breaks maestro
In-Reply-To: <20010131223006.A231@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0101301649290.1799-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Pavel Machek wrote:
>
> Hi!
> 
> With acpi support turned on, maestro does not work. Turn acpi off, and
> maestro is working, again.
> 								Pavel
>

Funny, I was browsing that source code the other day, and while I found
most of it unreadable, I found that it was talking about powermanagement
and such with the driver, with crazy attempts at making programs using it
sleep and cleanly turning on the power managment for the Maestro.  (The
Maestro appears to be able to turn off parts of itself to conserve
energy).

Now, I don't use any type of Power Management, so I can't say what's going
on, much less do I understand the source code completely enough to say
that's it *for sure*... but it seems that's one of those drivers that was
written by volunteers (Alan Cox and someone else, I can't think of their
name off hand), who by far didn't design the hardware.

The driver works for me with few problems, without power management.  If I
could program well enough in C to even comprehend what all that is in that
file, I might be able to try to hack it enough to fix it up to work... but
that's a far cry from the knowledge that I have now.  I couldn't write a
regular user-space program that actually did something useful (other than
being a suid wrapper) for the life of me.  :-)

In fact the only programs I've successfully written for Linux, and gotten
to work, is a program that I use set-uid to start my Internet
connection.  :-)

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
