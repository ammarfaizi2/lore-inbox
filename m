Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQK2Ae2>; Tue, 28 Nov 2000 19:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129267AbQK2AeS>; Tue, 28 Nov 2000 19:34:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32277 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129228AbQK2AeQ>; Tue, 28 Nov 2000 19:34:16 -0500
Date: Wed, 29 Nov 2000 01:04:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: John Kennedy <jk@csuchico.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001129010416.J14675@athlon.random>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com> <20001125145701.A12719@athlon.random> <20001128150235.A7323@north.csuchico.edu> <20001129002009.I14675@athlon.random> <20001128153615.E7323@north.csuchico.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001128153615.E7323@north.csuchico.edu>; from jk@csuchico.edu on Tue, Nov 28, 2000 at 03:36:15PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 03:36:15PM -0800, John Kennedy wrote:
>   No, it is all ext3fs stuff that is touching the same areas your

Ok this now makes sense. I ported VM-global-7 on top of ext3 right now
but it's untested:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7-against-ext3-0.0.3b-1.bz2

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
