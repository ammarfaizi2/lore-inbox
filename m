Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284659AbSAEVaH>; Sat, 5 Jan 2002 16:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285130AbSAEV3r>; Sat, 5 Jan 2002 16:29:47 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:58628 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S284659AbSAEV3q>; Sat, 5 Jan 2002 16:29:46 -0500
Date: Sat, 5 Jan 2002 22:06:14 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: RFC: The Big Patch List (was: Linux Kernel-2.4.18-nj1)
Message-ID: <20020105210614.GA19599@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020105180601.GC756@cpe-24-221-152-185.az.sprintbbd.net> <20020105194140.67038.qmail@web20504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020105194140.67038.qmail@web20504.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jan 2002, willy tarreau wrote:

> Perhaps people who have a solid personal tree would
> like to continue this discussion off-list and find
> an arrangement about a single test tree. Concerning
> stable trees, I think that both Marcello's and
> Andrea's are rock solid. Othe people may want to use
> their distributor's.

What *I* personally would greatly appreciate: the Big List of Kernel
Patches. It would list a patch, what it does, what version of the kernel
it is against, where it can be found, and maybe where other versions can
be found or conflicts.

This list could e. g. look like (cast into any form you like, an
extensible one is a good idea); I've just picked a random patch that I
use, without any recommendation:

PATCH: Pre-Emptive Kernel
AUTHOR: Robert M. Love
SUMMARY: Makes most parts of the kernel preemptive to reduce latency.
URL: http://www.tech9.net/rml/linux/
PATCHES-STABLE: 2.4.16, 2.4.17   <- only list patches yielding working releases
PATCHES-STABLE-PRE: 2.4.18-pre1
PATCHES-DEVEL: 2.5.1
PATCHES-DEVEL-PRE: 2.5.2-pre1
REQUISITES: -
CONFLICTS: O(1) scheduler

Resembles MAINTAINERS? Rightly so, just more detail given.

That way, we would not need to have so many distinct trees, but this
could easily grow into a patch repository where people could pull their
patches from. I presume that conflicts between patches meant for
inclusion will be worked out; maybe this list should announce
sub-versions of the patches, like Willy mentioned:

PATCH: ReiserFS for ext3-enabled kernels
AUTHOR: Hans Reiser et al.; Matthias Andree et al. (ext3 compatibility)
URL: http://mandree.home.pages.de/kernelpatches/v2.2/v2.2.19/
PATCHES-STABLE: 2.2.19
PATCHES-STABLE-PRE: -
PATCHES-DEVEL: -
PATCHES-DEVEL-PRE: -
REQUISITES: -
CONFLICTS: -

You get the idea. Comments?

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
