Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAFP0Z>; Sat, 6 Jan 2001 10:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAFP0O>; Sat, 6 Jan 2001 10:26:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5131 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129752AbRAFP0C>; Sat, 6 Jan 2001 10:26:02 -0500
Subject: Re: Even slower NFS mounting with 2.4.0
To: chris@chrullrich.de (Christian Ullrich)
Date: Sat, 6 Jan 2001 15:27:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010106002531.A490@christian.chrullrich.de> from "Christian Ullrich" at Jan 06, 2001 12:25:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EvGE-0001A8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I called the mount command five minutes before the final message above.
> I tried NFS with and without NFSv3 code, with no change at all.

This is caused by 2.3/2.4 changes in the network code error reporting of
unreachables with UDP I suspect. It looks like the NFS code hasn't yet caught
up with the error notification stuff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
