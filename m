Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbRGDINK>; Wed, 4 Jul 2001 04:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265741AbRGDIMv>; Wed, 4 Jul 2001 04:12:51 -0400
Received: from SMTP7.ANDREW.CMU.EDU ([128.2.10.87]:4366 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S265736AbRGDIMm>; Wed, 4 Jul 2001 04:12:42 -0400
Date: Wed, 4 Jul 2001 04:12:41 -0400 (EDT)
From: Ari Heitner <aheitner@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <01070317045806.00338@starship>
Message-ID: <Pine.GSO.4.21L-021.0107040305380.23815-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Jul 2001, Daniel Phillips wrote:

> And by the way, this is just brainstorming, it hasn't reached the 'proposal' 
> stage yet.

So while we're here, an idea someone proposed in #debian while discussion this
thread (michal@203.94.140.52, you know who you are): QoS for application paging
on desktops. Basically you designate to the kernel which applications you want
to give priviledges, and it avoids swapping them out, even if they've been idle
for a long time. You designate your desktop apps, and then when updatedb comes
along they don't get kicked (but something more intensive like a kernel compile
would claim the pages). Maybe it would be as simple as a category of apps whose
pages won't get kicked before a singly-touched page (like and updatedb or
streaming media run).

For the record, I'm impressed with the new VM design, and I think its unbiased
behaviour (once the bugs are ironed out) will be exactly what I'm looking for
in life (traditional Unix "the fair way") :) Currently using a 4-way RS/6000
running AIX 4.2 which has been up for a long time and is running a lot of
programs (even though the active set is quite reasonable), and decides to swap
at evil times :)

Looking forward to the tweaks/settings options that will appear on this VM over
the next little while...



Cheers,

Ari Heitner



