Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132347AbQKDB3d>; Fri, 3 Nov 2000 20:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132361AbQKDB3P>; Fri, 3 Nov 2000 20:29:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:54567 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132347AbQKDB3J>; Fri, 3 Nov 2000 20:29:09 -0500
Date: Sat, 4 Nov 2000 02:29:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gareth Hughes <gareth@valinux.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: SETFPXREGS fix
Message-ID: <20001104022905.E32767@athlon.random>
In-Reply-To: <20001103174105.C857@athlon.random> <3A034F28.5DB994F4@valinux.com> <20001104020709.D32767@athlon.random> <3A0362BD.D6068EDE@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A0362BD.D6068EDE@valinux.com>; from gareth@valinux.com on Sat, Nov 04, 2000 at 12:13:33PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 12:13:33PM +1100, Gareth Hughes wrote:
> Yes, we can certainly mask out the mxcsr value in both cases.  I just
	  ^^^
s/can/must/

> think this makes the code a lot simpler and cleaner as a result - three

I agree about the three vs one copy issue. Anyways my first priority was that
the the code was safe, and the previous one was completly safe too (ok, I admit
I had to check out the asm generated before trusting it 8).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
