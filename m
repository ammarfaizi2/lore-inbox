Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135655AbREFMqs>; Sun, 6 May 2001 08:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135658AbREFMqi>; Sun, 6 May 2001 08:46:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28165 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135655AbREFMqZ>; Sun, 6 May 2001 08:46:25 -0400
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 6 May 2001 13:47:47 +0100 (BST)
Cc: cw@f00f.org (Chris Wedgwood), andrea@suse.de (Andrea Arcangeli),
        axboe@suse.de (Jens Axboe), R.E.Wolff@BitWizard.nl (Rogier Wolff),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), volodya@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105052338580.26799-100000@weyl.math.psu.edu> from "Alexander Viro" at May 05, 2001 11:59:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wNwy-00022t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> an interesting task when your root lives on /dev/sda1. Ditto for destroying
> a single partition (not mounted/used by swap/etc.) while you have some
> other partition in use. IWBNI we had a decent API for handling partition
> tables...

Partitions are just very crude logical volumes, and ultimiately I believe
should be handled exactly that way
