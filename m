Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUGESKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUGESKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUGESKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:10:01 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:46861 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S266167AbUGESJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:09:36 -0400
Date: Mon, 5 Jul 2004 20:09:33 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <200407051513.48334.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.21.0407051733310.14602-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Jul 2004, Bartlomiej Zolnierkiewicz wrote:
> On Monday 05 of July 2004 14:14, Szakacsits Szabolcs wrote:
> 
> >     - nobody could point out any _technical_ benefit why the new
> > HDIO_GETGEO code is better than the old one (the _way_ Andries wanted to
> 
> Andries pointed it many times but you seem to completely ignore it

Hmmm. I'm recovering people's partition tables in my spare time,
voluntarily, free of charge when they got trashed due to Andries' and
Andrew's bugs over the last two years (gpart, testdisk and parted's 
rescue mode don't always work),

     http://mlf.linux.rulez.org/mlf/ezaz/ntfsresize.html#troubleshoot

I reported them several bugs, hints, reasons, potential reasons, guesses,
user feature request both privately and publicly.

I do know very well Andries' arguments, I've learnt them the hard way.
Actually I responded them several times, even in this thread.

> I also pointed out that IDE driver _doesn't_ need BIOS geometry et all.

Thanks but I thought it was off-topic and think the same now, too. It was
explained several times.

However none of you who responded seems to understand, still, what I want
to say.

You can't fix, for example, parted 1.6.11 and all earlier versions when
one does a 2.4 -> 2.6 kernel upgrade. If a user uses an old enough tool on
the new kernels then it can trash its partition table whatever the OS it
is (not only the geometry but the layout in sectors, too).

Also, sometimes [even very popular] distros ship one or two old tools, no
need for kernel upgrade. Whenever a user use the shipped old tool on 2.6
it can trash the partition table, being during install or later.

You, Bartlomiej Zolnierkiewicz, Andries Brouwer and Steffen Winterfeldt
say don't care about those people. OK, at least now it's documented
and this thread can be pointed out as a reference in the future.

Since there is nothing I could do more if maintainers aren't willing to
fix their more destructive 2.6 kernel code, the case is closed from my
part by this email.

Thanks,
	Szaka

