Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbQKGMMG>; Tue, 7 Nov 2000 07:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQKGML5>; Tue, 7 Nov 2000 07:11:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30326 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129555AbQKGMLl>; Tue, 7 Nov 2000 07:11:41 -0500
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 7 Nov 2000 12:11:57 +0000 (GMT)
Cc: motyl@stan.chemie.unibas.ch (Tomasz Motylewski),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <9769.973567485@ocs3.ocs-net> from "Keith Owens" at Nov 07, 2000 02:24:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7ba-0007KF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed, I was unhappy that the build symlink was added to 2.2 kernels.
> Now you need modutils >= 2.3.14 for 2.2 kernels :(.  But nobody asks
> me, I'm just the kernel module.[ch] and modutils maintainer.

Actually they do. I agree that it wants sorting. Im just wondering what the
best approach is - maybe check modutils rev and only add the link if its high
enough ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
