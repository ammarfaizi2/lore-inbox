Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSHFRhr>; Tue, 6 Aug 2002 13:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSHFRhr>; Tue, 6 Aug 2002 13:37:47 -0400
Received: from 24.213.60.125.up.mi.chartermi.net ([24.213.60.125]:65208 "EHLO
	back1.chartermi.net") by vger.kernel.org with ESMTP
	id <S315120AbSHFRhp>; Tue, 6 Aug 2002 13:37:45 -0400
From: "Russell, Nathaniel" <reddog83@chartermi.net>
Subject: Re: [PATCH] trivial patch for 2.4.20-pre1 8139too.c driver 
 (fwd)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.3
Date: Tue, 06 Aug 2002 13:41:23 -0400
Message-ID: <web-46527136@back1.chartermi.net>
In-Reply-To: <3D4FF809.4040106@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My i ask what the sense is to not remove the dead code if
 all we are trying to do is stablize the 2.4x kernel series
 and not add extra code or change around the drivers for
 perticular hardware. The code is not used anymore so why
 keep it in the 2.4x series. The code can stay in the 2.5x
 series no problem because there we can change drivers
 rewrite hardware protocalls and tthings like that. 


Marcelo Tosatti wrote:
>
>---------- Forwarded message ----------
>Date: Tue, 6 Aug 2002 00:15:21 +0000
>From: Nathaniel Russell <reddog83@chartermi.net>
>To: marcelo@conectiva.com.br
>Cc: alan@lxorguk.ukuu.org.uk
>Subject: [PATCH] trivial patch for 2.4.20-pre1 8139too.c
 driver
>
>This patch removes unneeded code for the Realtek driver
 this patch does not
>harm the performance of the driver at all it just removes
 dead code
>
>
>------------------------------------------------------------------------
>
>diff -urN linux-2.4/drivers/net/8139too.c.tmp
 linux/drivers/net/8139too.c
>--- linux-2.4/drivers/net/8139too.c.tmp	Mon Aug  5
 18:06:03 2002
>+++ linux/drivers/net/8139.c	Tue Aug  6 00:09:20 2002
>@@ -211,7 +211,6 @@
> 	RTL8139 = 0,
> 	RTL8139_CB,
> 	SMC1211TX,
>-	/*MPX5030,*/
> 	DELTA8139,
> 	ADDTRON8139,
> 	DFE538TX,
[...]


Please -do not- apply this patch.  This "dead code" exists
 for comment purposes, and also is a placeholder for
 future, better support for this chip.

	Jeff





