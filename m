Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTAAOZA>; Wed, 1 Jan 2003 09:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTAAOZA>; Wed, 1 Jan 2003 09:25:00 -0500
Received: from tomts26.bellnexxia.net ([209.226.175.189]:29418 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267235AbTAAOY7>; Wed, 1 Jan 2003 09:24:59 -0500
Date: Wed, 1 Jan 2003 09:32:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a few more "make xconfig" inconsistencies
In-Reply-To: <20030101141644.GI14184@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301010922160.18348-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

> > [rpjday@mindspring.com]
> >
> >   even if, under "Networking options", i deselect IPv6,
> > i'm still presented with an inactive IPv6 Netfilter Configuration
> > screen.
> 
> This is fixed in both 2.4.20 & 2.5.53 as far as I can see.

i'm looking at 2.4.20 with the 2.4.21-pre2 patch as we speak,
and, under "make xconfig", after deselecting IPv6, i am still
presented with a (deactivated) IPv6 netfilter configuration
dialog.

granted, it's deactivated (is that what you were referring to?)
but it's still presented to me.  this seems to be inconsistent
with one of your recent patches -- don't show arcnet dialog if
arcnet is deselected.

am i understanding all this correctly?
> 
> Could you have a look at 2.5.53's setup screens, though,
> and let me know if you can find any inconsistencies there
> (I'm sure you can :D)?

i'm downloading it as we speak. :-)  but on a more general note,
here's something i was thinking about -- some of the more general
selections should have their overall select button moved up in 
the hierarchy.

case in point:  under "General setup", there are two (what do
you call those things?) selectable entries for "PCMCIA/CardBus
support" and "PCI Hotplug Support".  why not make them selectable
entries, so i can deselect *all* of PCMCIA/Cardbus support 
immediately right there?

as it is, i have to move on to the actual dialog, in which i
can deselect all of it in one click.  there are other examples:
"Networking options" -> "Appletalk protocol support".  right now,
even though it's deselected, the net line reads "Appletalk devices"
and that dialog *will* come up, albeit deactivated.

anyway, i'll switch over to 2.5.53 and let you know what i find.

rday



