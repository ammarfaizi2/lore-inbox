Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbRFAW1k>; Fri, 1 Jun 2001 18:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbRFAW1b>; Fri, 1 Jun 2001 18:27:31 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:63237 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261758AbRFAW1Y>; Fri, 1 Jun 2001 18:27:24 -0400
Date: Fri, 1 Jun 2001 15:27:23 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Magnus.Sandberg@bluelabs.se
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org,
        magnus.sandberg@test.bluelabs.se
Subject: Re: Problem with kernel 2.2.19 Ultra-DMA and SMP, once more
In-Reply-To: <OFE14B9341.A598AA4B-ONC1256A5E.00770506@bluelabs.se>
Message-ID: <Pine.LNX.4.10.10106011525220.10960-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If this is a VIA SMP system there are APIC problems that you do not want
to even think about addressing.

MPS1.1 and passing "noapic" will fix most of there mess, but you have a
semi-crippled system, but it runs.

On Fri, 1 Jun 2001 Magnus.Sandberg@bluelabs.se wrote:

> Hi once more...
> 
> I'm sorry for the layout of this mail. It is written in a web mail
> system...
> The attachements are in ASCII format even if the web-mail make it base-64
> 
> Now I have compiled a vanilla 2.2.19 kernel and have SMP working, without
> Ultra-DMA. I used the functional kernel config from 2.2.19-ide and just
> activated SMP.
> 
> >From that I have 3 very simular kernel configurations:
> 2.2.19 with Hidrick's IDE-patch, no SMP: working
> 2.2.19 without IDE-patch, with SMP: working
> 2.2.19 with IDE-patch and SMP: not booting
> 
> With all the information I hope that someone can help me with the
> IDE-and-SMP
> problem.
> 
>                                   _\\|//_
>                                   (-0-0-)
> /-------------------------------ooO-(_)-Ooo------------------------------\
> | Magnus Sandberg                    Email: Magnus.Sandberg@bluelabs.se  |
> | Network Engineer, Bluelabs                     http://www.bluelabs.se/ |
> | Phone: +46-8-470 2155    (FAX: +46-8-470 2199)    GSM: +46-708-225 805 |
> \------------------------------------------------------------------------/
>                                   ||   ||
>                                  ooO   Ooo

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

