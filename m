Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTBEPVN>; Wed, 5 Feb 2003 10:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTBEPVN>; Wed, 5 Feb 2003 10:21:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:54726 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261463AbTBEPVM>; Wed, 5 Feb 2003 10:21:12 -0500
Date: Wed, 05 Feb 2003 07:30:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: vda@port.imtp.ilyichevsk.odessa.ua,
       Herman Oosthuysen <Herman@WirelessNetworksInc.com>
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <193350000.1044459007@[10.10.2.4]>
In-Reply-To: <200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua>
References: <200302042011.h14KBuG6002791@darkstar.example.net>
 <3E40264C.5050302@WirelessNetworksInc.com>
 <200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> GCC already went this way, i.e. it aligns functions and loops by
> ridiculous (IMHO) amounts like 16 bytes. That's 7,5 bytes per alignment
> on average. Now count lk functions and loops and mourn for lost icache.
> Or just disassemble any .o module and read the damn code.
> 
> This is the primary reason why people report larger kernels for GCC 3.x
> 
> I am damn sure that if you compile with less sadistic alignment
> you will get smaller *and* faster kernel.

There's only one real way to know that. Do it, test it.

M.

