Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAKBcN>; Wed, 10 Jan 2001 20:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRAKBcD>; Wed, 10 Jan 2001 20:32:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38919 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129584AbRAKBby>; Wed, 10 Jan 2001 20:31:54 -0500
Subject: Re: [PATCH] 2.2.18pre21 ide-disk.c for OB800
To: andre@linux-ide.org (Andre Hedrick)
Date: Thu, 11 Jan 2001 01:33:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), grundler@cup.hp.com (Grant Grundler),
        linux-kernel@vger.kernel.org, taggart@fc.hp.com, m.ashley@unsw.edu.au
In-Reply-To: <Pine.LNX.4.10.10101101725070.26556-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 10, 2001 05:28:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GWc2-0001QZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay then are you wanting me to create a struct or bit mask to carry the
> the device settings/mode that is set before an APM/ACPI event happens.
> 
> Regardless that the answer is wrong, somebody/thing has to keep a copy of
> the device settings, and the case of swapout they get nuked.  Thus a
> reprobe must happen. yes/no?

Quite probably. It just needs to happen before we need to touch the disk. It
could be we need to mlock something or that the kernel needs to keep it
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
