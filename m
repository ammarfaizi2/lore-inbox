Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJEfa>; Tue, 9 Jan 2001 23:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132437AbRAJEfU>; Tue, 9 Jan 2001 23:35:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23825 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129764AbRAJEfM>; Tue, 9 Jan 2001 23:35:12 -0500
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
To: billc@netcomuk.co.uk (Bill Crawford)
Date: Wed, 10 Jan 2001 04:37:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, crawford@goingware.com
In-Reply-To: <3A5BE344.11429FDC@netcomuk.co.uk> from "Bill Crawford" at Jan 10, 2001 04:21:25 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GD0W-0008AA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  The Mesa package in Red Hat 7 won't do DRI with recent XFree86 CVS.

Yep. Its Mesa 3.3/DRI 1.0. XFree86 CVS is Mesa 3.4/DRI 2.0. That has several
advantages including mostly working on Matrox cards which 1.0 never did (for
me anyway) and handling things that Mesa 3.3 tried to allocate the odd gig
of ram for and then exploded.

With the CVS stuff the 2.4 kernel should work out of the box. You need -ac for
some ALi AGP chipsets.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
