Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271764AbRIHRTI>; Sat, 8 Sep 2001 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271761AbRIHRS7>; Sat, 8 Sep 2001 13:18:59 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:30178 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S271697AbRIHRSl>;
	Sat, 8 Sep 2001 13:18:41 -0400
Message-Id: <m15flku-000QFYC@amadeus.home.nl>
Date: Sat, 8 Sep 2001 18:18:56 +0100 (BST)
From: arjan@fenrus.demon.nl
To: Eric.Brunet@physics.unige.ch (Brunet Eric)
Subject: Re: Two bugs: PCMCIA doesn't work and bad DMA/APM interaction
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010908190133.B5716@serifos.unige.ch>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010908190133.B5716@serifos.unige.ch> you wrote:
> Hello all,

> (insmod's output is:
> /lib/modules/2.4.10-pre4/kernel/drivers/pcmcia/i82365.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> )


that's because you need the "yenta_socket.o" module for cardbus!
