Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOBea>; Tue, 14 Nov 2000 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQKOBeU>; Tue, 14 Nov 2000 20:34:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45185 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129045AbQKOBeJ>;
	Tue, 14 Nov 2000 20:34:09 -0500
Date: Tue, 14 Nov 2000 16:49:23 -0800
Message-Id: <200011150049.QAA01994@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: karrde@callisto.yi.org
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011150250050.28006-100000@callisto.yi.org>
	(message from Dan Aloni on Wed, 15 Nov 2000 02:59:36 +0200 (IST))
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011150250050.28006-100000@callisto.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Wed, 15 Nov 2000 02:59:36 +0200 (IST)
   From: Dan Aloni <karrde@callisto.yi.org>

   On Tue, 14 Nov 2000, David S. Miller wrote:

   > Then the compiler will start warning us :-)

   I've also noticed that routing_ioctl() in arch/mips64/kernel/ioctl32.c
   assumes the 16. Are those two platforms depend on having IFNAMSIZ == 16,
   or this code just needs cleaning up?

No, it means the code "may need changing" if IFNAMSIZ is ever
changed.  The compiler will warn us when this happens instead
of silently compiling the code.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
