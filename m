Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbQKPWOl>; Thu, 16 Nov 2000 17:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131212AbQKPWOb>; Thu, 16 Nov 2000 17:14:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131209AbQKPWOV>; Thu, 16 Nov 2000 17:14:21 -0500
Subject: Re: APM oops with Dell 5000e laptop
To: brad@neruo.com (Brad Douglas)
Date: Thu, 16 Nov 2000 21:43:14 +0000 (GMT)
Cc: dax@gurulabs.com (Dax Kelson), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001116203922Z129069-521+734@vger.kernel.org> from "Brad Douglas" at Nov 17, 2000 04:08:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wWoN-0008PC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do not believe so.  I tend to think that detecting these broken models is a waste of kernel code (especially, if there's an effort to correct the problem).

One idea the Dell folks suggested is walking the SMBIOS data table. That happens
to be something I want to do as its the only good way I know to get

	o	Cache sizes on older machines
	o	The type of monitoring device (lm78 etc) attached
	o	slot information

I have user space code to walk these tables so I have a basis to attack this
in 2.2.19

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
