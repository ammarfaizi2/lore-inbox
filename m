Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135841AbREFU6S>; Sun, 6 May 2001 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135844AbREFU6I>; Sun, 6 May 2001 16:58:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5639 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135841AbREFU5t>; Sun, 6 May 2001 16:57:49 -0400
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: adilger@turbolinux.com (Andreas Dilger)
Date: Sun, 6 May 2001 21:58:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        cw@f00f.org (Chris Wedgwood), andrea@suse.de (Andrea Arcangeli),
        axboe@suse.de (Jens Axboe), R.E.Wolff@bitwizard.nl (Rogier Wolff),
        torvalds@transmeta.com (Linus Torvalds), volodya@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200105061946.f46JkkFr026005@webber.adilger.int> from "Andreas Dilger" at May 06, 2001 01:46:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wVc1-0002aj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, the EVMS project does exactly this.  All I/O is done on a full
> disk basis, and essentially does block remapping for each partition.  This
> also solves the problem of cache inconsistency if accessing the parent
> device vs. accessing the partition.

Interesting. Can EVMS handle the partition labels used by the LVM layer - ie
could it replace it as well ?
