Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbQKAMrU>; Wed, 1 Nov 2000 07:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130090AbQKAMrK>; Wed, 1 Nov 2000 07:47:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37392 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130616AbQKAMqw>; Wed, 1 Nov 2000 07:46:52 -0500
Subject: Re: test10-pre7
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 1 Nov 2000 12:46:41 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rmk@arm.linux.org.uk (Russell King),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <21820.973046146@ocs3.ocs-net> from "Keith Owens" at Nov 01, 2000 01:35:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qxHu-0000OT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of SCSI cards is not a good enough reason.  People with multiple SCSI
> cards already change the order of scsi entries to get the probe order
> that suits them, LINK_FIRST will make that even easier.

Why not solve the generic problem. If you give a list of requirements to
tsort one per line it will tell you the order. You just need to turn a set
of ordering needs into a tsort input

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
