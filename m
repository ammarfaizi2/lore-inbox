Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292866AbSCKUbv>; Mon, 11 Mar 2002 15:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292873AbSCKUbl>; Mon, 11 Mar 2002 15:31:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292866AbSCKUba>;
	Mon, 11 Mar 2002 15:31:30 -0500
Message-ID: <3C8D140F.7030507@mandrakesoft.com>
Date: Mon, 11 Mar 2002 15:31:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        trivial@rustcorp.com.au
Subject: Re: [PATCH] Trivial compile fix
In-Reply-To: <200203111408.g2BE8pq05486@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>--- linux-2.5.6-pre2/drivers/net/8139cp.c.orig	Mon Mar 11 13:17:59 2002
>+++ linux-2.5.6-pre2/drivers/net/8139cp.c	Mon Mar 11 15:44:48 2002
>@@ -47,7 +47,6 @@
> #define DRV_VERSION		"0.0.7"
> #define DRV_RELDATE		"Feb 27, 2002"
> 
>-
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/netdevice.h>
>@@ -59,6 +58,7 @@
> #include <linux/mii.h>
> #include <asm/io.h>
> #include <asm/uaccess.h>
>+#include <linux/crc32.h>
>
Please CC the maintainer (me) on such patches.  Also, don't remove blank 
lines I put in there to make the code look nice... :)

    Jeff




