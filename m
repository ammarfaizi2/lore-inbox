Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRBLVty>; Mon, 12 Feb 2001 16:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131372AbRBLVtp>; Mon, 12 Feb 2001 16:49:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26117 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131231AbRBLVta>; Mon, 12 Feb 2001 16:49:30 -0500
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
To: carlos@fisica.ufpr.br (Carlos Carvalho)
Date: Mon, 12 Feb 2001 21:49:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14984.18005.694178.241076@hoggar.fisica.ufpr.br> from "Carlos Carvalho" at Feb 12, 2001 06:23:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SQqi-0008Bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> net/network.a(sunrpc.o): In function `xprt_ping_reserve':
> sunrpc.o(.text+0x4b94): undefined reference to `BUG'
> sunrpc.o(.text+0x4b98): undefined reference to `BUG'
> 
> Looks like a problem in Trond's patches, also it doesn't happen with
> pre9. It links in intel machines. I didn't reboot to test yet...

The ideal solution would be for someone to provide BUG() on the Alpha platform
as in 2.4. That would sort things cleanly

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
