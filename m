Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSE0KyG>; Mon, 27 May 2002 06:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSE0KyF>; Mon, 27 May 2002 06:54:05 -0400
Received: from thoth.sbs.de ([192.35.17.2]:42674 "EHLO thoth.sbs.de")
	by vger.kernel.org with ESMTP id <S316603AbSE0KyF>;
	Mon, 27 May 2002 06:54:05 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'David Brownell'" <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: RE: ehci-hcd on CARDBUS hangs when stopping card service
Date: Mon, 27 May 2002 14:54:00 +0400
Message-ID: <6134254DE87BD411908B00A0C99B044F02E89AFF@mowd019a.mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <3CED6E0B.8020501@pacbell.net>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'll hope that problem appears only in 2.4.18-6mdk, and isn't found in
> other kernels.  In particular, if it's in 2.5.17 then there's a big
> hole in the "new driver model" work (struct device etc)!
> 

Absolutely the same code is in 2.4.18 and 2.4.19-pre8 so it is not
something Mandrake has introduced. The reason it has not been noticed
before is probably that not every driver hangs here (in reported case
ohci went through even though it could not access controller properly).

-andrej
