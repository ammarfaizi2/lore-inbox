Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUGCB6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUGCB6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 21:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUGCB6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 21:58:21 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:31761 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265784AbUGCB5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 21:57:53 -0400
Date: Sat, 3 Jul 2004 03:57:49 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Anton Altaparmakov <aia21@cam.ac.uk>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, clausen@gnu.org, buytenh@gnu.org,
       msw@redhat.com
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for
 BIOS / CHS stuff)
In-Reply-To: <20040703005555.GA20808@apps.cwi.nl>
Message-ID: <Pine.LNX.4.21.0407030310430.19875-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Jul 2004, Andries Brouwer wrote:

> (i) Szaka wrote stuff that I interpreted as stating (a) that parted
> is seriously broken, and (b) that parted is unmaintained.

Right. Parted is definitely looking for (co)maintainers (note, I've never
written parted is unmaintained, even though I think _practically_ it is).

Unfortunately most discussions were in private with FSF/GNU people after I
wrote this to the bug-parted mailing list

  http://lists.gnu.org/archive/html/bug-parted/2004-03/msg00091.html

I'm sure Andrew won't be angry if I quote one of his private emails
(please note he is quite busy with his study, made already heroic efforts
but clearly couldn't/can't focus on the emerging issues).

  Final comment: I think I am inadequate as a maintainer for GNU Parted.
  However, as there are no other volunteers, I am better than nothing.
  Some people have started working on Parted, and I make try to give them
  advice, apply patches, etc.  But, all of these people to date have been
  too busy to take over long-term Parted maintainence.
 
> Concerning the "seriously broken" part, looking at the various available
> sources I find that indeed parted has always been seriously broken,
> but now Andrew has added stuff in an attempt to fix things.
> His added stuff is broken as well, but clearly work is being done,

He was told many many times since last November how to do it correctly.
Even you told him but he still couldn't cope with all the tasks.

> so instead of shouting on the kernel list it seems more productive

Please see subject: "[RFC] Restoring HDIO_GETGEO semantics", it has
nothing to do with parted maintaince.

Fixing parted won't fix all the tools people currently use still trusting
the newer kernels. You can't force everybody to replace immediately their
parted/etc even if they got fixed.

Sorry, I can't explain better. Maybe somebody who gets what I want to say
could translate it to real, understandable English. I'd really appreciate.

> to tell Andrew precisely in what ways his stuff is broken.
> I would expect that very soon parted is fine.

Unfortunately things always went to the wrong direction in the last 8
months. No matter who and how tried to explain.

> (ii) Various people talk about moving disks between machines.

I've seen only Patrick mentioning this.

> Such people have not understood the main fact here:
> the geometry is not a property of the disk but of the BIOS.
> It is futile to hope for a construction that will work across
> different machines with different BIOSes.

Exactly. This is why e.g. ntfsck, mkntfs, recovery and other tools need to
get this value reliable from somewhere. But they can't.

	Szaka

