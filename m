Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbQLDPgQ>; Mon, 4 Dec 2000 10:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLDPgH>; Mon, 4 Dec 2000 10:36:07 -0500
Received: from mout0.freenet.de ([194.97.50.131]:52616 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129775AbQLDPfz>;
	Mon, 4 Dec 2000 10:35:55 -0500
From: mkloppstech@freenet.de
Message-Id: <200012041505.QAA00381@john.epistle>
Subject: filesystem corruption with 2.4.0-test11
To: linux-kernel@vger.kernel.org
Date: Mon, 4 Dec 2000 16:05:36 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My filesystem was checked because it contained errors.

The warnings in my message file are:
Dec  4 13:04:19 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #280596: rec_len % 4 != 0 - offset=0, inode=68583844, rec_len=13758, name_len=0
Dec  4 15:38:07 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #280596: rec_len % 4 != 0 - offset=0, inode=33188, rec_len=3591, name_len=0
Dec  4 15:38:07 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #659481: directory entry across
blocks - offset=0, inode=33188, rec_len=2536, name_len=0
Dec  4 15:39:38 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #280596: rec_len % 4 != 0 - offset=0, inode=33188, rec_len=3591, name_len=0
Dec  4 15:39:38 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #659481: directory entry across
blocks - offset=0, inode=33188, rec_len=2536, name_len=0

fsck does not repair anything.

Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
