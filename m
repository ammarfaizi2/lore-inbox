Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSFEXmZ>; Wed, 5 Jun 2002 19:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316459AbSFEXmY>; Wed, 5 Jun 2002 19:42:24 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:21888
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316322AbSFEXmV>; Wed, 5 Jun 2002 19:42:21 -0400
Date: Wed, 5 Jun 2002 16:42:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add <linux/kdev_t.h> to <linux/bio.h>
Message-ID: <20020605234201.GC709@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <20020605232220.GA709@opus.bloom.county> <20020606003420.A17872@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 12:34:20AM +0100, Russell King wrote:
> On Wed, Jun 05, 2002 at 04:22:20PM -0700, Tom Rini wrote:
> > The following add <linux/kdev_t.h> to <linux/bio.h>.
> > 
> > This is needed since bio_ioctl takes a kdev_t for its first argument.
> 
> This should be fixed by a patch I submitted earlier today (you're getting
> a build error in fs/mpage.c, right?)

Nope.  This was with that applied.  I'm breaking up mm.h, slightly,
right now and hit that.

> hch asked the very pertinent question though - why isn't kdev_t defined
> by linux/types.h ?

That is a good question...  Possibly because of the other stuff
associated with it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
