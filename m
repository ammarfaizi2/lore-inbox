Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKFV37>; Mon, 6 Nov 2000 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQKFV3u>; Mon, 6 Nov 2000 16:29:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26208 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129148AbQKFV3o>; Mon, 6 Nov 2000 16:29:44 -0500
Subject: Re: setup.S: A20 enable sequence (once again)
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 6 Nov 2000 21:30:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8u6vn8$70i$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 06, 2000 11:10:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13stqG-0006eJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't really work.  Neither the fast A20 gate nor the KBC is
> guaranteed to have immediate effect (on most systems they won't.)

Fast A20 gate happens to be immediate on all the embedded kit I know so its
probably acceptable, and if its too slow it still does the kbc timeout. Since
its generally on chip they dont muck about talking to keyboard and other junk
I/O controllers.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
