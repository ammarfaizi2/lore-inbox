Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUDEQpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUDEQpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:45:09 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:33688 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262954AbUDEQpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:45:04 -0400
Date: Mon, 05 Apr 2004 09:44:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: akpm@digeo.com, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] 2.6.5- es7000 subarch update
Message-ID: <261610000.1081183494@[10.10.2.4]>
In-Reply-To: <452548B29F0CCE48B8ABB094307EBA1C04C55160@USRV-EXCH2.na.uis.unisys.com>
References: <452548B29F0CCE48B8ABB094307EBA1C04C55160@USRV-EXCH2.na.uis.unisys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you explain this bit? Looks slightly odd, and looks like something
others might be using ...

M.


> diff -Naur linux6.5/arch/i386/kernel/mpparse.c linux-2.6.5/arch/i386/kernel/mpparse.c
> --- linux6.5/arch/i386/kernel/mpparse.c	2004-04-04 18:22:39.000000000 -0400
> +++ linux-2.6.5/arch/i386/kernel/mpparse.c	2004-04-05 00:07:13.000000000 -0400
> @@ -969,7 +969,7 @@
>  	 */
>  	for (i = 0; i < mp_irq_entries; i++) {
>  		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
> -			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
> +			&& (mp_irqs[i].mpc_dstirq == intsrc.mpc_dstirq)) {
>  			mp_irqs[i] = intsrc;
>  			found = 1;
>  			break;

