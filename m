Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277052AbRJKXWY>; Thu, 11 Oct 2001 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277053AbRJKXWO>; Thu, 11 Oct 2001 19:22:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13532 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277052AbRJKXVz>;
	Thu, 11 Oct 2001 19:21:55 -0400
Date: Thu, 11 Oct 2001 19:22:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Christian Ullrich <chris@chrullrich.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <Pine.LNX.3.96.1011011180912.5934I-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0110111919110.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Jeff Garzik wrote:

> To tangent, do we really need a mount cache that big, even on a highmem
> machine?

Probably not - feel free to cut it down.  Anything larger than about
a thousand vfsmounts (on a box with a lot of bindings and several
chroot environment playing interesting games) is an overkill...

