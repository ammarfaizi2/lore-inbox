Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbRALXq6>; Fri, 12 Jan 2001 18:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbRALXqt>; Fri, 12 Jan 2001 18:46:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47621 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129957AbRALXqb>; Fri, 12 Jan 2001 18:46:31 -0500
Subject: Re: ide.2.4.1-p3.01112001.patch
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 12 Jan 2001 23:47:41 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010112212427.A2829@suse.cz> from "Vojtech Pavlik" at Jan 12, 2001 09:24:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HDv7-0005G6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However - Alan's IDE patch for 2.2 kills autodma on ALL VIA chipsets.
> That's because all VIA chipsets starting from vt82c586 to vt82c686b
> (UDMA100), share the same PCI ID.

I have no reports of problems with the later stuff

> Would you prefer to filter just vt82c586 and vt82c586a as the comment in
> Alan's code says or simply unconditionally kill autodma on all of VIA
> chipsets, as Alan's code does?

I'd take a 2.2 patch to cut down the range too
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
