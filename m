Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbREVTW7>; Tue, 22 May 2001 15:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbREVTWu>; Tue, 22 May 2001 15:22:50 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:6981 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262730AbREVTWk>;
	Tue, 22 May 2001 15:22:40 -0400
Message-ID: <20010522212238.A11203@win.tue.nl>
Date: Tue, 22 May 2001 21:22:38 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Oliver Xymoron <oxymoron@waste.org>, Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct char_device
In-Reply-To: <5.1.0.14.2.20010522153915.00ac1630@pop.cus.cam.ac.uk> <Pine.LNX.4.30.0105221104070.19818-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0105221104070.19818-100000@waste.org>; from Oliver Xymoron on Tue, May 22, 2001 at 11:08:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 11:08:16AM -0500, Oliver Xymoron wrote:

> > >+       struct list_head        hash;

> > Why not name consistently with the struct block_device?
> >          struct list_head        cd_hash;

> Because foo_ is a throwback to the days when C compilers had a single
> namespace for all structure elements, not a readability aid. If you need
> foo_ to know what type of structure you're futzing with, you need to name
> your variables better.

One often has to go through all occurrences of a variable or
field of a struct. That is much easier with cd_hash and cd_dev
than with hash and dev.

No, it is a good habit, these prefixes, even though it is no longer
necessary because of the C compiler. 
