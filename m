Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269874AbRHIX0r>; Thu, 9 Aug 2001 19:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269875AbRHIX0i>; Thu, 9 Aug 2001 19:26:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43425 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269874AbRHIX0f>;
	Thu, 9 Aug 2001 19:26:35 -0400
Date: Thu, 9 Aug 2001 19:26:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
In-Reply-To: <532210000.997396954@tiny>
Message-ID: <Pine.GSO.4.21.0108091856020.25945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Aug 2001, Chris Mason wrote:

> 
> 
> On Thursday, August 09, 2001 06:24:46 PM -0400 Alexander Viro <viro@math.psu.edu> wrote:
> 
> > Chris, how about doing that after fs/super.c stuff (things that went into
> > -ac)?
> > 
> 
> well, it depends on how soon the fs/super.c stuff goes in ;-)

That, in turn, depends on Linus. Since this stuff got public testing
in -ac (since 2.4.7-ac3) and since Linus had said that he doesn't mind
patches landing in his mailbox after each prerelease... ;-)

I'll resubmit that stuff - let's see when it gets applied...

> I'd prefer to provide you with an updated patch for -ac, and get
> this into the kernel sooner than later.  It's your call though, including
> if you just want to hold off until I've got the -ac patch done.

I think that doing variant against -ac first (or just fs/super.c stuff
that went into -ac) makes a lot of sense, since it will simplify testing.
We need this stuff in the tree and it's 2.4 matter - we need to close
the oopsen. I'd rather get tricky (and already debugged) stuff first
and then deal with relatively simple patch atop of it.

