Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTAAOhN>; Wed, 1 Jan 2003 09:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTAAOhN>; Wed, 1 Jan 2003 09:37:13 -0500
Received: from [81.2.122.30] ([81.2.122.30]:65030 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267070AbTAAOhM>;
	Wed, 1 Jan 2003 09:37:12 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301011445.h01EjK3Q000861@darkstar.example.net>
Subject: Re: a few more "make xconfig" inconsistencies
To: rpjday@mindspring.com (Robert P. J. Day)
Date: Wed, 1 Jan 2003 14:45:20 +0000 (GMT)
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301010922160.18348-100000@dell> from "Robert P. J. Day" at Jan 01, 2003 09:32:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> case in point:  under "General setup", there are two (what do
> you call those things?) selectable entries for "PCMCIA/CardBus
> support" and "PCI Hotplug Support".  why not make them selectable
> entries, so i can deselect *all* of PCMCIA/Cardbus support 
> immediately right there?
> 
> as it is, i have to move on to the actual dialog, in which i
> can deselect all of it in one click.  there are other examples:
> "Networking options" -> "Appletalk protocol support".  right now,
> even though it's deselected, the net line reads "Appletalk devices"
> and that dialog *will* come up, albeit deactivated.

The interfaces for the 2.4 and 2.5 xconfig systems are completely
different.

For 2.4, I think it's a very bad idea to not to show the greyed-out
options, because a switch disabling all of them is set.  Having a
switch to disable, for example, all of the power management options is
useful, because they are amoungst other options, and I can just ignore
them and scroll past quickly and easily.

I think it would be a big waste of time if we have to start toggling
options just to see which options are being hidden.

For 2.5, each subcategory can be 'collapsed', so this problem doesn't
really occur.

John.
