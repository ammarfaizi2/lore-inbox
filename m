Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGQdF>; Wed, 7 Feb 2001 11:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBGQc4>; Wed, 7 Feb 2001 11:32:56 -0500
Received: from host217-32-130-65.hg.mdip.bt.net ([217.32.130.65]:12549 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129026AbRBGQcj>;
	Wed, 7 Feb 2001 11:32:39 -0500
Date: Wed, 7 Feb 2001 16:35:32 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: [reiserfs] SPEC SFS fails at low loads...
Message-ID: <Pine.LNX.4.21.0102071633331.712-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Under 2.4.1, after a little bit of running SPEC SFS (with NFSv3) I get
these messages on the server:

vs-13042: reiserfs_read_inode2: [0 1 0x0 SD] not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found

and the run aborts.

Any clues?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
