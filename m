Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRAOC4i>; Sun, 14 Jan 2001 21:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbRAOC42>; Sun, 14 Jan 2001 21:56:28 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:17904 "EHLO
	lappi.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S130781AbRAOC4V>; Sun, 14 Jan 2001 21:56:21 -0500
Date: Mon, 15 Jan 2001 00:56:10 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: ebiederm@xmission.com (Eric W. Biederman), riel@nl.linux.org,
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010115005610.E1656@bacchus.dhis.org>
In-Reply-To: <m17l40hhtd.fsf@frodo.biederman.org> <200101122111.f0CLBhL10716@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101122111.f0CLBhL10716@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Jan 12, 2001 at 09:11:43PM +0000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:11:43PM +0000, Russell King wrote:

> Eric W. Biederman writes:
> > Hmm.  I would think that increasing the logical page size in the kernel
> > would be the trivial way to handle virtual aliases.  (i.e.) with a large
> > enough page size you can't actually have a virtual alias.
> 
> There are types of caches out there that no matter how large the page size,
> you will always have alias issues.  These are ones where the cache lines
> are indexed independent of virtual address (and therefore can have funny
> cache line replacement algorithms).
> 
> And yes, you guessed which processor has it. ;)

I recently spoke with some CPU architecture researcher at some university
about cache architectures; I suspect in the near future we'll see more
funny cache indexing and replacment algorithems ...

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
