Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131790AbQKVAEi>; Tue, 21 Nov 2000 19:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131829AbQKVAE2>; Tue, 21 Nov 2000 19:04:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131790AbQKVAEL>; Tue, 21 Nov 2000 19:04:11 -0500
Subject: Re: e2fs performance as function of block size
To: cma@mclink.it (CMA)
Date: Tue, 21 Nov 2000 23:34:36 +0000 (GMT)
Cc: tytso@mit.edu, card@masi.ibp.fr, linux-kernel@vger.kernel.org
In-Reply-To: <000001c053f4$7e7fbc40$65000a0a@cma.it> from "CMA" at Nov 21, 2000 08:46:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yMvv-0005Ly-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sirs,
> performing extensive tests on linux platform performance, optimized as
> database server, I got IMHO confusing results:
> in particular e2fs initialized to use 1024 block/fragment size showed
> significant I/O gains over 4096 block/fragment size, while I expected t=
> he
> opposite. I would appreciate some hints to understand this.

It may be that your database is writing out 1K sized blocks on random
boundaries. If so then the behaviour you describe would be quite reasonable.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
