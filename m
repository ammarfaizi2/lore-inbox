Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSGEKFO>; Fri, 5 Jul 2002 06:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSGEKFN>; Fri, 5 Jul 2002 06:05:13 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11581 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316679AbSGEKFL>; Fri, 5 Jul 2002 06:05:11 -0400
Date: Fri, 5 Jul 2002 12:08:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrey Nekrasov <andy@spylog.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa4 & Intel EtherExpress driver "e100".
Message-ID: <20020705100830.GX1227@dualathlon.random>
References: <20020620170047.GB1134@dualathlon.random> <20020621073140.GA30147@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621073140.GA30147@spylog.ru>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 11:31:40AM +0400, Andrey Nekrasov wrote:
> Hello.
> 
> 1. My hardware:
> 
> M/B Intel STL2:
> 	- ServerWorks ServerSet III LE chipset).
>   - Integrated on-board Intel EtherExpress PRO100+ 10/100mbit PCI controller
>     (Intel 82559)
> 
> 
> 2. Problem:
> 
> 2.4.19pre10aa3 - load kernel & driver ok, work.
> ...
> Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.8.38                      Copyright (c) 2002 Intel Corporation                                                                       
> eth0: Intel(R) 8255x-based Ethernet Adapter                                           
> Mem:0xfb101000  IRQ:18  Speed:100 Mbps  Dx:Full
> Hardware receive checksums enabled cpu cycle saver enabled                                
> ...
> 
> 
> 2.4.19pre10aa4 :
> ....
> Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.30-k1
> Copyright (c) 2002 Intel Corporation
> 
> hw init failed
> Failed to initialize e100, instance #0
> ....
> 
> 
> Whay?

because I upgreaded the driver to 2.0.30 from jam2. Due your report I
backed out 2.0.30 from rc1aa1 and I returned to 1.8.38.

Can you confirm rc1aa1 works again? in next -aa I'll upgrade again to
the 2.0.30-k release using another patch to see if it still malfunction
for you.

Andrea
