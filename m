Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLQMKw>; Sun, 17 Dec 2000 07:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLQMKn>; Sun, 17 Dec 2000 07:10:43 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:25092 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129455AbQLQMKd>; Sun, 17 Dec 2000 07:10:33 -0500
Date: Sun, 17 Dec 2000 11:39:50 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: <2181.977050264@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0012171134540.14423-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000, Keith Owens wrote:

> The rest of the kernel already depends totally on these "subtle" issues
> with link order.  Why should mtd be different?

Because I maintain the MTD code and I want it to be. I think the link
order dependencies are ugly, unnecessary and far more likely to be
problematic then the alternatives. I'll code an alternative which is
cleaner than the current code, and Linus can either accept it or not, as
he sees fit.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
