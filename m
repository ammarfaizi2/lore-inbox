Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbQKLKFL>; Sun, 12 Nov 2000 05:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbQKLKFC>; Sun, 12 Nov 2000 05:05:02 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:2550 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S130355AbQKLKEr>;
	Sun, 12 Nov 2000 05:04:47 -0500
Date: Sun, 12 Nov 2000 02:04:45 -0800
From: Richard Henderson <rth@redhat.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: rth@cygnus.com, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
Message-ID: <20001112020445.A12864@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0011101618030.17943-100000@weyl.math.psu.edu> <20001111140634.A4865@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <20001111140634.A4865@bacchus.dhis.org>; from Ralf Baechle on Sat, Nov 11, 2000 at 02:06:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 02:06:34PM +0100, Ralf Baechle wrote:
> Reminds me that the Alpha implementation of get_wchan() looks to me like
> it doesn't handle all cases of schedule() being called from another
> scheduler function correctly.

Certainly not -- it's impossible.

> I'd really like to see a wchan field in task_struct to avoid
> get_wchan breaking every once in a while.

Indeed.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
