Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274200AbRISWBj>; Wed, 19 Sep 2001 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274202AbRISWBd>; Wed, 19 Sep 2001 18:01:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52485 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274200AbRISWBV>; Wed, 19 Sep 2001 18:01:21 -0400
Subject: Re: NFS in 2.4.8/9ac
To: ted@cypress.com (Thomas Dodd)
Date: Wed, 19 Sep 2001 23:06:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <3BA90A57.6090803@cypress.com> from "Thomas Dodd" at Sep 19, 2001 04:12:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jpUE-0003z8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > eth0: Lite-On 82c168 PNIC rev 33 at 0xe400, 00:A0:CC:50:35:C2, IRQ 10
> > (Tulip FA310TX card)

Same as mine

> Just a note: This is still a problem.
> eventually I'll get a message about task slots.

Thats the NFS backlog filling. That itself does not indicate a problem of
any kind just congestion - which if the card is getting tx timeouts and
watchdog errors would be reasonable

> On a new Athlon 1.4 box, with a LNE100TX NIC
> it's there with the default kernel from Red Hat Linux 7.1
> (2.4.2-2.i686.rpm), and on a P4-1.8GHz with the same NIC.

Well 2.4.2 is in my prehistory pile. I dont know if this has been fixed
or is known - Jeff Garzik may do.

Alan
