Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTAQRBv>; Fri, 17 Jan 2003 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTAQRBu>; Fri, 17 Jan 2003 12:01:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41918 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267599AbTAQRBt>; Fri, 17 Jan 2003 12:01:49 -0500
Date: Fri, 17 Jan 2003 09:10:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: John Cherry <cherry@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <279000000.1042823444@titus>
In-Reply-To: <1042822516.14996.10.camel@cherrypit.pdx.osdl.net>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com> <1042822516.14996.10.camel@cherrypit.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compile statistics: 2.5.59
> 
> Not much change.
> 
>                            2.5.58                       2.5.59
>                        ------------------------ ------------------------
> bzImage (defconfig)      20 warnings/0 errors     20 warnings/0 errors
> bzImage (allmodconfig)   32 warnings/9 errors     32 warnings/9 errors
> modules (allmodconfig) 3156 warnings/154 errors 3119 warnings/159 errors
> 
> Compile statistics have been for kernel releases from 2.5.46 to 2.5.59
> at: www.osdl.org/archive/cherry/stability

I think tracking this this a great idea - all these warnings make it really 
hard to see what's going on. Is there any change you could add a PAE enabled 
config to the setup? Tends to generate lots of stupid warnings about 
typecasts when people do printk("%08lx", dma_addr_t_thingy);

Thanks,

M.

