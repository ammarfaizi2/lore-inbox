Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129062AbQJ3NmW>; Mon, 30 Oct 2000 08:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129252AbQJ3NmM>; Mon, 30 Oct 2000 08:42:12 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:24594 "HELO
	gateway.izba.bg") by vger.kernel.org with SMTP id <S129062AbQJ3Nl4>;
	Mon, 30 Oct 2000 08:41:56 -0500
Date: Mon, 30 Oct 2000 18:41:51 +0200 (EET)
From: <lnxkrnl@mail.ludost.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PLIP driver in 2.2.xx kernels
In-Reply-To: <E13pWzo-0005MJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10010301840320.15258-100000@doom.izba.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Oct 2000, Alan Cox wrote:

> >   I have a question - Why does the PLIP driver does consume so much CPU ?
> > I tried it today, and when i did ping -s 16000 dst_ip, the kernel consumed
> > about 50% of the CPU time ( /proc/cpuinfo and /proc/interrupts follow).
> > Any ideas ?
> 
> It has to bang on the parallel port controller the hard way, there is no
> useful hardware support on a basic parallel port for the kind of abuse needed
> for PLIP
> 
(sorry for the late reply)
 I used plip with kernel 1.2.8 and had no problem with it...The machines
that I'm using now are far superior than the old ones... Why shouldn't it
work now ? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
