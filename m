Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265493AbUGCARa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUGCARa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUGCARa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:17:30 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:43536 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265493AbUGCAR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:17:28 -0400
Date: Sat, 3 Jul 2004 02:17:26 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for
 BIOS / CHS stuff)
In-Reply-To: <s5gvfh6xklo.fsf@patl=users.sf.net>
Message-ID: <Pine.LNX.4.21.0407030201520.30622-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jul 2004, Patrick J. LoPresti wrote:

> You will find that the default_* files (i.e., the geometry from the
> extended INT13 interface) match the values returned by HDIO_GETGEO.

If my memory serves well, you wrote once long ago that your project needs
the "legacy" value to make things work.

Kernel 2.4 guessed usually legacy, right? 

Kernel 2.6 returns extended and it more upsets tools and users with
trashed partitions.

So a simple question: why is returning the extended values better than
returning always the legacy values (or even the previous guess)?

I _do_ know that that won't be perfect either but perhaps it weren't so
broken as it is now. 

BTW, so far nobody answered what the technical benefit returning the
extended values instead of the legacy ones or the previous guess. 
We only know the current values hurt more and there are only better
alternatives, right?

	Szaka

