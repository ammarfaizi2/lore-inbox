Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129522AbQKPFwf>; Thu, 16 Nov 2000 00:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbQKPFwP>; Thu, 16 Nov 2000 00:52:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6441 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129522AbQKPFwD>; Thu, 16 Nov 2000 00:52:03 -0500
Subject: Re: Modprobe local root exploit
To: Torsten.Duwe@caldera.de
Date: Thu, 16 Nov 2000 05:22:33 +0000 (GMT)
Cc: fg@mandrakesoft.com (Francis Galiegue), linux-kernel@vger.kernel.org
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de> from "Torsten Duwe" at Nov 13, 2000 05:45:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wHVO-0007VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
> 
>     Francis> Just in case... Some modules have uppercase letters too :)
> 
> That's what the &0xdf is intended for...

That looks wrong for UTF8 which is technically what the kernel uses 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
