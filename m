Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbQL1QR3>; Thu, 28 Dec 2000 11:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbQL1QRT>; Thu, 28 Dec 2000 11:17:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130392AbQL1QRH>; Thu, 28 Dec 2000 11:17:07 -0500
Subject: Re: Repeatable Oops in 2.4t13p4ac2
To: chris@freedom2surf.net
Date: Thu, 28 Dec 2000 15:48:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <978009656.3a4b3e38c7455@www.freedom2surf.net> from "chris@freedom2surf.net" at Dec 28, 2000 01:20:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BfI7-0003qn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi - we are seeing the following repeatable Oops in 2.4t13p4ac2 compiled using 
> gcc 2.95.2 for PIII running on IDE disks. Occurs whilst copying lots of files 
> to/from remote filesystems.

I've had a couple of reports like this. Can you test 2.4t13p4 without the -ac
changes. If the -ac changes cause it then I need to know, but with the -ac
changes nobody else will care ;)

So the first way to narrow it down is that

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
