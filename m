Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLRWID>; Mon, 18 Dec 2000 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbQLRWHx>; Mon, 18 Dec 2000 17:07:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62982 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129524AbQLRWHh>; Mon, 18 Dec 2000 17:07:37 -0500
Subject: Re: Disabling interrupts in 2.4.x
To: Brian_Boerner@adaptec.com (Boerner, Brian)
Date: Mon, 18 Dec 2000 21:39:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.redhat.com')
In-Reply-To: <E9EF680C48EAD311BDF400C04FA07B612D4DA4@ntcexc02.ntc.adaptec.com> from "Boerner, Brian" at Dec 18, 2000 02:57:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14880U-0006Ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would expect this function to disable interrupts, but given the scale of
> change between 2.2.x spinlock.h and 2.4.x spinlock.h I'm just not sure
> anymore. 

spin_lock_irqsave disables interrupts but only on the CPU that the lock
is taken.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
