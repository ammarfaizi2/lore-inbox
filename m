Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRAaKtQ>; Wed, 31 Jan 2001 05:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbRAaKtG>; Wed, 31 Jan 2001 05:49:06 -0500
Received: from smtp.mountain.net ([198.77.1.35]:58377 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S130339AbRAaKs7>;
	Wed, 31 Jan 2001 05:48:59 -0500
Message-ID: <3A77ED7F.466582F0@mountain.net>
Date: Wed, 31 Jan 2001 05:48:31 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns> <3A77966E.444B1160@linux.com> <3A77C6E7.606DDA67@mountain.net> <20010131042616.A32636@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Tom Leete]
> > It's not an incompatibility with the k7 chip, just bad code in
> > include/asm-i386/string.h.
> 
> So you're saying SMP *is* supported on Athlon?  Do motherboards exist?
> 
> Peter

No, I'm saying that SMP locking etc. is compatible with Athlon. The failure
to build is not a workaround but a coding error. SMP builds for UP machines
are supposed to work.

Tom
-- 
The Daemons lurk and are dumb. -- Emerson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
