Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130872AbQK1N2O>; Tue, 28 Nov 2000 08:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131152AbQK1N1y>; Tue, 28 Nov 2000 08:27:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32032 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130872AbQK1N1r>; Tue, 28 Nov 2000 08:27:47 -0500
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
To: vherva@mail.niksula.cs.hut.fi (Ville Herva)
Date: Tue, 28 Nov 2000 12:57:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001128145229.O53529@niksula.cs.hut.fi> from "Ville Herva" at Nov 28, 2000 02:52:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140kKf-0004U3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wasn't the one who used cdrom, so it is possible, that the person in
> question had been able to eject the cd without unmounting it first. I'll
> check if the door locking on that device works.

Also rpm -e magicdev --nodeps if magicdev is on the box.

> But you are certain that the oops was eventually caused by these and not
> by any bug in vm?

This one . Yes.

The VM layer isnt causing any oopses I've seen in 2.2.17+. It doesn't always
make good choices and Rik or Andrea's stuff is on the list after 2.2.18
(I refuse to mix VM changes with the big driver changes)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
