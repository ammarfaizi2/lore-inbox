Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276411AbRJPRWT>; Tue, 16 Oct 2001 13:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJPRWJ>; Tue, 16 Oct 2001 13:22:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45505 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276411AbRJPRWA>;
	Tue, 16 Oct 2001 13:22:00 -0400
Date: Tue, 16 Oct 2001 13:22:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: John Levon <moz@compsoc.man.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <20011016180757.A78456@compsoc.man.ac.uk>
Message-ID: <Pine.GSO.4.21.0110161312110.14170-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Oct 2001, John Levon wrote:

> On Tue, Oct 16, 2001 at 09:27:55AM -0700, Christoph Lameter wrote:
> 
> > /lib/modules/2.4.11/kernel/drivers/block/loop.o: Note: modules without a
> > GPL compatible license cannot use GPLONLY_ symbols
> > 
> > What is THAT?
> 
> A symbol that may only be referenced by GPL code.
> 
> The solution here is to add MODULE_LICENSE("GPL") into loop.c (probably)
> or upgrade (assuming it's fixed later).

invalidate_bdev() is _not_ GPL-only.  Never had been, never will.

