Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPO5u>; Sat, 16 Dec 2000 09:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLPO5k>; Sat, 16 Dec 2000 09:57:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13376 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129345AbQLPO5d>; Sat, 16 Dec 2000 09:57:33 -0500
Date: Sat, 16 Dec 2000 15:26:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jani Monoses <jani@virtualro.ic.ro>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: mark_inode_dirty question
Message-ID: <20001216152653.A26034@inspiron.random>
In-Reply-To: <Pine.LNX.4.10.10012161442080.10586-100000@virtualro.ic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012161442080.10586-100000@virtualro.ic.ro>; from jani@virtualro.ic.ro on Sat, Dec 16, 2000 at 02:47:16PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 02:47:16PM +0200, Jani Monoses wrote:
> mark_inode_dirty and mark_inode_dirty_sync .Could the i_state be changed
> during the call (on another CPU)?

no because you're protected by the inode_lock.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
