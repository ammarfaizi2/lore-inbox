Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQLQPu1>; Sun, 17 Dec 2000 10:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQLQPuR>; Sun, 17 Dec 2000 10:50:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129664AbQLQPuL>; Sun, 17 Dec 2000 10:50:11 -0500
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2)
To: kaos@ocs.com.au (Keith Owens)
Date: Sun, 17 Dec 2000 15:20:40 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), rasmus@jaquet.dk (Rasmus Andersen),
        linux-kernel@vger.kernel.org
In-Reply-To: <2181.977050264@ocs3.ocs-net> from "Keith Owens" at Dec 17, 2000 09:51:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147fcB-0004ET-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Woodhouse <dwmw2@infradead.org> wrote:
> >The conditional compilation is far more obvious to people than subtle
> >issues with link order. So I prefer to avoid the latter at all costs.
> 
> The rest of the kernel already depends totally on these "subtle" issues
> with link order.  Why should mtd be different?

Why should mtd be broken just because the rest of the Makefiles are

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
