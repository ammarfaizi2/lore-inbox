Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXPdD>; Fri, 24 Nov 2000 10:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKXPcx>; Fri, 24 Nov 2000 10:32:53 -0500
Received: from kanga.kvack.org ([216.129.200.3]:49925 "EHLO kanga.kvack.org")
        by vger.kernel.org with ESMTP id <S129145AbQKXPcg>;
        Fri, 24 Nov 2000 10:32:36 -0500
Date: Fri, 24 Nov 2000 10:00:51 -0500 (EST)
From: <kernel@kvack.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: "H . J . Lu" <hjl@valinux.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek patch for 2.2.18pre23
In-Reply-To: <20001124152153.A23297@athlon.random>
Message-ID: <Pine.LNX.3.96.1001124095942.22053A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Andrea Arcangeli wrote:

> And in LFS (that means also 2.4.x) the >> 32 doesn't make any sense in lseek
> and should be removed:

Actually, the >> 32 part was there to avoid doing the long long comparison
on x86.  Granted, that probably doesn't matter.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
