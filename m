Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129479AbRBKROH>; Sun, 11 Feb 2001 12:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRBKRN5>; Sun, 11 Feb 2001 12:13:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64524 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129137AbRBKRNs>; Sun, 11 Feb 2001 12:13:48 -0500
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
To: nicku@vtc.edu.hk (Nick Urbanik)
Date: Sun, 11 Feb 2001 17:14:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel list)
In-Reply-To: <3A868782.55ED2B5F@vtc.edu.hk> from "Nick Urbanik" at Feb 11, 2001 08:37:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S04y-0004Tb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.2-pre3 doesn't compile with 6pack as a module; I had to disable it;
> now it compiles (and so far, works fine).

It has a slight dependancy on -ac right now.

KMALLOC_MAXSIZE is the alloc size limit - 131072. It checks this as kmalloc
now panics if called with an oversize request


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
