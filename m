Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRATQXl>; Sat, 20 Jan 2001 11:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRATQXX>; Sat, 20 Jan 2001 11:23:23 -0500
Received: from mail.t-intra.de ([62.156.146.210]:18031 "EHLO mail.t-intra.de")
	by vger.kernel.org with ESMTP id <S129884AbRATQXI>;
	Sat, 20 Jan 2001 11:23:08 -0500
Message-Id: <200101201622.f0KGMQT03162@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "neilb@cse.unsw.edu.au" <neilb@cse.unsw.edu.au>
Date: Sat, 20 Jan 2001 17:23:27 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Serious file system corruption with RAID5+SMP and kernels above 2.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two days ago I tried new kernels on my SMP SW RAID5 System
and expirienced serous file system corruption with kernels 2.4.1-pre8,9 as 2.4.0-ac8,9,10.
The same error has been reported by other people on this list. With 2.4.0 release
everything runs fine. So I backsteped to it and had no error since.

Comparing Patches from 2.4.1-pre8,9  and 2.4.0-ac10,9  leads me to the question if the
chances to the MMX und i387 code in this patches could have broken raid5 under SMP?

My boot.log file states that it uses p5_mmx block moves for performance reasons.

In the 2.4.1 series are no changes to raid5 but the corruption issue which expirience are in both
kernel series the same.

Best regards



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
