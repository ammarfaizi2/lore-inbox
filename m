Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPT12>; Thu, 16 Nov 2000 14:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKPT1R>; Thu, 16 Nov 2000 14:27:17 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:61959 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129076AbQKPT1G>;
	Thu, 16 Nov 2000 14:27:06 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011161856.VAA03745@ms2.inr.ac.ru>
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 16 Nov 2000 21:56:54 +0300 (MSK)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E13wThz-0008C0-00@the-village.bc.nu> from "Alan Cox" at Nov 16, 0 06:24:26 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > It means that test for CAP_SYS_MODULE is illegal, moving pure policy
> > issue to improper place.
> 
> Definitely not so
> 
> What matters is whether the user is requesting a module or the kernel is 
> choosing to load a module. In the former case where the user can influence the
> module name then you need to check CAP_SYS_MODULE in the latter you do not
> care.

Alan, I honestly peered to this paragraph of text for 10 minutes. 8)8)

It is funny, but I managed to compile it only as:
"dev_load(i.e. you) need not take of care of this".

I.e. exactly the thing which I said. 8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
