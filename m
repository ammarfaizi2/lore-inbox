Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbRAIKam>; Tue, 9 Jan 2001 05:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAIKab>; Tue, 9 Jan 2001 05:30:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130218AbRAIKaW>; Tue, 9 Jan 2001 05:30:22 -0500
Subject: Re: [PATCH] hisax/sportster dependency error
To: stodden@in.tum.de
Date: Tue, 9 Jan 2001 10:32:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org,
        kai@thphy.uni-duesseldorf.de (Kai Germaschewski),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <874rz9t6om.fsf@bitch.localnet> from "Daniel Stodden" at Jan 09, 2001 10:30:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fw4b-0006No-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Almost every 10bit decode ISA card is like that. You don't need to do the
> > work. The PCI alloc rules already cover it.
> 
> so, if i understand this correctly, since all offsets actually in use
> are 1024B multiples the following would be sufficient, or more elegant..?

PCI allocation rules handle all of this. PCI I/O is not allocated in the
ranges 0x[1-F][0-3]xx

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
