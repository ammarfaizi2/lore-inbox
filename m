Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132656AbQLNS7A>; Thu, 14 Dec 2000 13:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132654AbQLNS6u>; Thu, 14 Dec 2000 13:58:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3844 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132620AbQLNS6m>; Thu, 14 Dec 2000 13:58:42 -0500
Subject: Re: Fwd: [Fwd: [PATCH] cs89x0 is not only an ISA card]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 14 Dec 2000 18:29:50 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw),
        nico@cam.org (Nicolas Pitre), morton@nortelnetworks.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A38FC9D.7B2F2B7D@mandrakesoft.com> from "Jeff Garzik" at Dec 14, 2000 12:00:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146d8Z-00008m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For an embedded board that supports cs89x0, as you suggest, defining
> CONFIG_ISA is a much better option.  Or, making cs89x0 dependent on

No its completely wrong. You can have a CS89xx series device without the
slightest hint of ISA bus. 

What would be a lot cleaner though would be to build a custom config.in for
such embedded devices not referencing the mainstream one

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
