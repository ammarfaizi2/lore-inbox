Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAMUPC>; Sat, 13 Jan 2001 15:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRAMUOw>; Sat, 13 Jan 2001 15:14:52 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:59144 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129401AbRAMUOn>;
	Sat, 13 Jan 2001 15:14:43 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101132014.f0DKEJh153332@saturn.cs.uml.edu>
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
To: cr@sap.com (Christoph Rohland)
Date: Sat, 13 Jan 2001 15:14:19 -0500 (EST)
Cc: david+validemail@kalifornia.com, linux-kernel@vger.kernel.org
In-Reply-To: <m33denk0p2.fsf@linux.local> from "Christoph Rohland" at Jan 13, 2001 03:04:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland writes:

> I am quite open about naming, but "shm" is not appropriate any more
> since the fs does a lot more than shared memory. Solaris calles this
> "tmpfs" but I did not want to 'steal' their name and I also do not
> think that it's a very good name.

Admins already know what "tmpfs" means, so you should just call
your filesystem that. I know it isn't a pretty name, but in the
interest of reducing confusion, you should use the existing name.

Don't think of it as just "for /tmp". It is for temporary storage.
The name is a reminder that you shouldn't store archives in tmpfs.

Again for compatibility, Sun's size option would be useful.

-o size=111222333      Size in bytes, rounded up by page size.
-o size=111222k        Size in kilobytes (base-2 or ISO standard?)
-o size=111m           Size in megabytes (base-2 or ISO standard?)

I'd prefer k for ISO standard and K for base-2.
Of course m isn't millibytes, but that isn't horrible.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
