Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131646AbQLNSx6>; Thu, 14 Dec 2000 13:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbQLNSxi>; Thu, 14 Dec 2000 13:53:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2052 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129602AbQLNSxc>; Thu, 14 Dec 2000 13:53:32 -0500
Subject: Re: macro MSG_PEEK
To: marco@ca.provincia.parma.it
Date: Thu, 14 Dec 2000 18:25:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A38F21E.B135B1C8@ca.provincia.parma.it> from "Marco Nardelli" at Dec 14, 2000 04:15:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146d4a-00008f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "make test" gives me this problem:
> 
> t/07io..............Your vendor has not defined Socket macro MSG_PEEK,
> used at blib/lib/Convert/BER.pm line 968
> dubious

Um.. I suggest you go ask them to fix it

> Does anyone know where I can find the macro MSG_PEEK?

grep is your friend. Also its broken to assume its a macro - MSG_PEEK is 
entitled by an enum


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
