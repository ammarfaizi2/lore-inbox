Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264741AbUEOVpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbUEOVpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUEOVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 17:45:44 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:37525 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264741AbUEOVpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 17:45:43 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@lst.de>, netdev@oss.sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pete Popov <ppopov@mvista.com>
Subject: Re: [PATCH] remove comx drivers from tree
References: <20040507111725.GA11575@lst.de> <40A50292.3070601@pobox.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 15 May 2004 23:41:59 +0200
In-Reply-To: <40A50292.3070601@pobox.com> (Jeff Garzik's message of "Fri, 14
 May 2004 13:32:02 -0400")
Message-ID: <m3sme1cqqg.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> I have applied this to my netdev-2.6 tree, and so it should show up in
> -mm sometime.
>
>   drivers/net/wan/Kconfig           |  113 -
>   drivers/net/wan/Makefile          |    8
>   drivers/net/wan/comx-hw-comx.c    | 1449 -------------------
>   drivers/net/wan/comx-hw-locomx.c  |  495 ------
>   drivers/net/wan/comx-hw-mixcom.c  |  959 ------------
>   drivers/net/wan/comx-hw-munich.c  | 2853
>   --------------------------------------
>   drivers/net/wan/comx-proto-fr.c   | 1013 -------------
>   drivers/net/wan/comx-proto-lapb.c |  550 -------
>   drivers/net/wan/comx-proto-ppp.c  |  268 ---
>   drivers/net/wan/comx.c            | 1127 ---------------
>   drivers/net/wan/comx.h            |  231 ---
>   drivers/net/wan/comxhw.h          |  112 -

While obviously I don't object (we should list removed things along
with kernel version somewhere, though)... I could possibly port
the drivers to my generic HDLC code, if someone sends me the hardware
in question. Sure, I will never send it back, and it has to have V.35
or V.24 interface, so I can connect it to something.
-- 
Krzysztof Halasa, B*FH
