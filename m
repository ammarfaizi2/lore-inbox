Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131624AbQLHRho>; Fri, 8 Dec 2000 12:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbQLHRhe>; Fri, 8 Dec 2000 12:37:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23057 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131624AbQLHRha>; Fri, 8 Dec 2000 12:37:30 -0500
Subject: Re: Linux 2.2.18pre25
To: miquels@cistron.nl (Miquel van Smoorenburg)
Date: Fri, 8 Dec 2000 17:08:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), wtarreau@free.fr (Willy Tarreau),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001208170755.A28838@cistron.nl> from "Miquel van Smoorenburg" at Dec 08, 2000 05:07:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144R0z-0004AM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Some days I don't know why I bother
> Bad day, Alan? ;)

Umm no but having people _keep_ sending you do nothing patches gets
annoying after a while ;)

> reading the patch, it makes sense. It probably does about the same
> as Willy's patch, but the "right" way by using pci_resource_start()
> which the one in pre18 only did for kernels > 2.3.0

I suspect what actually happened is that someone fixed pci_resource_start()
looking over the change set, and that fixed the megaraid driver

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
