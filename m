Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbQKSBPl>; Sat, 18 Nov 2000 20:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132034AbQKSBPb>; Sat, 18 Nov 2000 20:15:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31794 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132073AbQKSBPR>; Sat, 18 Nov 2000 20:15:17 -0500
Date: Sun, 19 Nov 2000 01:45:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H . J . Lu" <hjl@valinux.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001119014512.G26779@athlon.random>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com> <20001118192542.B24555@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001118192542.B24555@athlon.random>; from andrea@suse.de on Sat, Nov 18, 2000 at 07:25:42PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 07:25:42PM +0100, Andrea Arcangeli wrote:
> I fixed it this way:

fix is plain wrong, it's still possible to have lseek return -1 -2 -3 -4
even when it should return -EINVAL.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
