Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLaBeC>; Sat, 30 Dec 2000 20:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135604AbQLaBdy>; Sat, 30 Dec 2000 20:33:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129348AbQLaBda>; Sat, 30 Dec 2000 20:33:30 -0500
Subject: Re: tdfx.o and -test13
To: jjs@pobox.com (J Sloan)
Date: Sun, 31 Dec 2000 01:05:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3A4E8190.DA4CB916@pobox.com> from "J Sloan" at Dec 30, 2000 04:45:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CWw1-0007GV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  +#include <linux/modversions.h>
> >   #include <linux/module.h>
> >   #include <linux/kernel.h>
> >   #include <linux/miscdevice.h>
> 
> I just want to confirm that this small fix solves my drm
> problems as well - currently running -test13-pre7
> 
> Er, has anybody sent a patch to the maintainers?

Wrong patch. Modversions.h should be getting automatically included. That
is what needs fixing. You've nicely located the problem and fixed the symptoms 
for the module versioned case

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
