Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLMVjY>; Wed, 13 Dec 2000 16:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132006AbQLMVjP>; Wed, 13 Dec 2000 16:39:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131956AbQLMVjF>; Wed, 13 Dec 2000 16:39:05 -0500
Subject: Re: insmod problem after modutils upgrading
To: chris@chrullrich.de (Christian Ullrich)
Date: Wed, 13 Dec 2000 21:10:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001213215915.A10848@christian.chrullrich.de> from "Christian Ullrich" at Dec 13, 2000 09:59:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146JAu-0003HX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > how can i make insmod load the network module again pls?
> 
> I "fixed" the same problem in 2.2.18 by commenting out the line
> 
> MODULE_PARM (debug, "i");
> 
> near the end of drivers/net/8139too.c. Since I run modutils 2.3.22
> as well, it can't be related to the modutils.

It is modutils. Their behaviour changed in a non back compatible way. Do not
use modutils 2.3.22 with Linux 2.2.* is the simple answer. Perhaps Keith can
make this a warning in 2.3.23
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
