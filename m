Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315582AbSECG7A>; Fri, 3 May 2002 02:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315583AbSECG67>; Fri, 3 May 2002 02:58:59 -0400
Received: from violet.setuza.cz ([194.149.118.97]:55559 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S315582AbSECG6z>;
	Fri, 3 May 2002 02:58:55 -0400
Subject: Re: Serial port- Linux kernel
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <GVHNWI$3922BF840A57031E8DFA5B1C29C46DC1@inwind.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 May 2002 08:58:56 +0200
Message-Id: <1020409136.272.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-02 at 16:50, antonelloderosa@inwind.it wrote:
> I must control the serial port at kernel level, because I have to make several measurements of one-way delay between a source and a destination host, so while I set the DTR on the source host when I send the UDP packet, the destination host must be able to set by itself the RTS when it receives the packet.
> 
> I'm quite a beginner in Linux-kernel, so may you help me more?
> 
> Thanks again
> 
> Antonello 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Hi Antonello,

if you're new to the kernel ( like me :o), you could take Rubini &
Corbets ``Linux Device Drivers'' book, and write a special driver for
your problem. That could be a nice task for learning the kernel.
I did something similar, programming a little parport-LED-lightshow.
Your real and my artificial problem enlightenes one in driver, module,
kernel and user-space / kernel-space relations, and is ( thus ) a fine
task to start with.

Regards
Frank

PS: Many thanks to Alessandro and Jonathan for this fine collection of
paper.



