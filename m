Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310886AbSCHOpM>; Fri, 8 Mar 2002 09:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310884AbSCHOpE>; Fri, 8 Mar 2002 09:45:04 -0500
Received: from Expansa.sns.it ([192.167.206.189]:50948 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S310881AbSCHOoz>;
	Fri, 8 Mar 2002 09:44:55 -0500
Date: Fri, 8 Mar 2002 15:44:54 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <Pine.LNX.4.44.0203081514430.28035-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.44.0203081544210.28168-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to specify that the oops occourse when initializing the IDE
controller.


On Fri, 8 Mar 2002, Luigi Genoni wrote:

> HI,
>
> It is almost impossible to boot 2.5.6 with IDE disk with
> chipset :
>
> 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> [Master])
>         Subsystem: Intel Corporation 82801AA IDE
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at 2460 [size=16]
>
>
> I get an oops with every configuration I tried.
> Of course I have no way to save log this oops,
> and I had no time to write it down. Anyway it is the usual
> "attemped to kill init" message.
>
> Apart of this there is the old OSS driver with still
> a virt_to_bus() in dma.c file,
> and drm/i810.c has the same problem too, also if a trivial
> (and of course wrong, also if it works temporally) fix
> is quite fast.
>
>
> I am willing to test any patch
>
> Luigi
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

