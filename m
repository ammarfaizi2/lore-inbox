Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSBcF>; Sat, 18 Nov 2000 20:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKSBb4>; Sat, 18 Nov 2000 20:31:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40208 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129136AbQKSBbx>; Sat, 18 Nov 2000 20:31:53 -0500
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 19 Nov 2000 01:01:23 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0011181943110.21893-100000@weyl.math.psu.edu> from "Alexander Viro" at Nov 18, 2000 07:46:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xIrF-0002D0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is probably in order. Alan? Place in question is the check for notify_change()
> growing the file past 4Gb - it should check for size >> 32, obviously.

The 2.2 limit is 2Gbytes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
