Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUGGLvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUGGLvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUGGLvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:51:36 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:7175 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265083AbUGGLvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:51:33 -0400
Date: Wed, 7 Jul 2004 13:51:28 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <Pine.LNX.4.58.0407071304190.20635@scrub.home>
Message-ID: <Pine.LNX.4.21.0407071324580.7176-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jul 2004, Roman Zippel wrote:

> At this point we either complete the job and remove this ioctl or we 
> restore the 2.4 behaviour (maybe with a deprecated warning).

Well, yes. Perhaps a competent guy/gal could even fix most of the broken
2.4 cases during the same time, e.g. by using EDD, if possible and make
sense. But somehow I doubt anybody would take this nasty retore&fix
challange and actually it's even possible.

I also say, things might rely on the 2.6 behavior now, thus they might be
broken by the restoration. They should be investigated to prevent
deserving another brown paper bag.

Andries says, it's not a kernel issue because he is going on vacation soon
(that's why he's off-topic all the time, wanting to adjust only the easy
user space quickly).

	Szaka

