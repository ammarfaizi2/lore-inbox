Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267223AbTAANfy>; Wed, 1 Jan 2003 08:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTAANfy>; Wed, 1 Jan 2003 08:35:54 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:48838 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267223AbTAANfx>; Wed, 1 Jan 2003 08:35:53 -0500
Date: Wed, 1 Jan 2003 08:43:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: make gigabit ethernet into a real submenu
In-Reply-To: <20030101131925.GA14184@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301010829270.11858-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

> Oh yes, definitely, I just wanted to be consistent with 10/100.
> So here comes gigabit the way you suggested (tested, seems to work
> fine), next I'll be sending a fix for 10/100, then see if there are
> any more menus like that left in the current config setup.

the other oddities(?) i noticed were (some admittedly trivial):

1) Under General setup, turning off Power Management support
   deactivated all of ACPI support, but had a weird effect on
   its sibling, Advanced Power Management BIOS support.
   not sure if this is supposed to happen, it just looks
   weird.

2) under Input core support, if you deselect Joystick support,
   there are still a number of selectable joystick-related
   features available under Character devices -> Joysticks
   (although these appear to be more than just basic joystick
   options -- is that the reason?)

3) Radio adapters is currently subsumed under Video for Linux,
   under Multimedia devices, which seems inappropiate.

i'm sure there were a couple of other oddities i noticed, if anyone
was interested.

rday

