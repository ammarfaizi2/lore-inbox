Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSHGB4t>; Tue, 6 Aug 2002 21:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSHGB4t>; Tue, 6 Aug 2002 21:56:49 -0400
Received: from huey.jpl.nasa.gov ([128.149.68.100]:58834 "EHLO
	huey.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S316897AbSHGB4s>; Tue, 6 Aug 2002 21:56:48 -0400
Message-ID: <3D507E36.9010109@jpl.nasa.gov>
Date: Tue, 06 Aug 2002 18:56:06 -0700
From: Bryan Whitehead <driver@jpl.nasa.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, thockin@hockin.org
Subject: Re: Linux 2.4.20-pre1
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------060104070309060302000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104070309060302000506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
> stuff.
> 
> 2.4.20 will be a much faster release cycle than 2.4.19 was.
> 
> 

This didn't make 2.4.19. Just a spelling error. I tried the maintainer 
but got no reply...

(yea yea... i just like clean logs... ) :)

;)

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

--------------060104070309060302000506
Content-Type: text/plain;
 name="natsemi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="natsemi.patch"

--- linux/drivers/net/natsemi.c.orig	Tue Aug  6 18:50:13 2002
+++ linux/drivers/net/natsemi.c	Tue Aug  6 18:50:38 2002
@@ -1685,7 +1685,7 @@
 			np->tx_config += 2;
 		if (netif_msg_tx_err(np))
 			printk(KERN_NOTICE 
-				"%s: increased Tx theshold, txcfg %#08x.\n",
+				"%s: increased Tx threshold, txcfg %#08x.\n",
 				dev->name, np->tx_config);
 		writel(np->tx_config, ioaddr + TxConfig);
 	}

--------------060104070309060302000506--

