Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbQKGMys>; Tue, 7 Nov 2000 07:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbQKGMyi>; Tue, 7 Nov 2000 07:54:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130642AbQKGMy3>; Tue, 7 Nov 2000 07:54:29 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jas88@cam.ac.uk (James A. Sutherland)
Date: Tue, 7 Nov 2000 12:52:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James A. Sutherland),
        goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <00110712495300.01753@dax.joh.cam.ac.uk> from "James A. Sutherland" at Nov 07, 2000 12:49:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t8ET-0007Nw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > eth0	pegasus
> > nopersist eth0
> > post-install eth0 /usr/local/sbin/my-dhcp-stuff
> 
> So, in short, this is already done perfectly well in userspace without some
> sort of Registry-style kernelside hack?

Thats the idea. Once the rmmod code can read back values the cycle is complete
and the kernel doesnt care

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
