Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRBKQX2>; Sun, 11 Feb 2001 11:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbRBKQXU>; Sun, 11 Feb 2001 11:23:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40972 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129643AbRBKQXI>; Sun, 11 Feb 2001 11:23:08 -0500
Subject: Re: problem with adding starfire driver to kernel 2.2.18
To: nneul@umr.edu (Nathan Neulinger)
Date: Sun, 11 Feb 2001 10:59:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A85C4A9.8CAD6466@umr.edu> from "Nathan Neulinger" at Feb 10, 2001 04:46:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RuE6-0003rL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically, it appears that it detects the same card more than once. In
> the case of the below dmesg output - the machine has 1 tulip based card,
> and 1 Adaptec Quartet64. The eth[5-8] are bogus.

The Don Becker drivers have had this bug for ages and ages now, long after
it has been reported it has not been fixed.

I think you'll have to hack on that yourself
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
