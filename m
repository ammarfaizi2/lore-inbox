Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKAQsx>; Wed, 1 Nov 2000 11:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKAQsn>; Wed, 1 Nov 2000 11:48:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6208 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129231AbQKAQs3>; Wed, 1 Nov 2000 11:48:29 -0500
Date: Wed, 1 Nov 2000 17:48:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Yann Dirson <ydirson@altern.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        riel@nl.linux.org, andrea@e-mind.com
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001101174816.A18510@athlon.random>
In-Reply-To: <20001101133307.A10265@bylbo.nowhere.earth> <Pine.LNX.4.21.0011010940450.2774-100000@freak.distro.conectiva> <20001101174339.A1167@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001101174339.A1167@bylbo.nowhere.earth>; from ydirson@altern.org on Wed, Nov 01, 2000 at 05:43:39PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 05:43:39PM +0100, Yann Dirson wrote:
> However, the OOM killer behaves in strange ways, it seems.  In the 2 "make

Fair enough as there isn't an oom killer in the kernel you're running :).
So it can kill unlucky tasks as well.

Since nobody cares to implement it, for 2.4.x on my TODO list there's an
alternative oom killer based on the task fault rate.

(btw, make sure you're using the -7 revision of the VM-global patch, as it
includes the same MM corruption bugfix that is been included into 18pre18)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
