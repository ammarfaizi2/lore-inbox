Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132772AbRC2Q1x>; Thu, 29 Mar 2001 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRC2Q1h>; Thu, 29 Mar 2001 11:27:37 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:56100 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132772AbRC2Q0H>; Thu, 29 Mar 2001 11:26:07 -0500
Date: Thu, 29 Mar 2001 11:25:08 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Message-ID: <20010329112507.A27209@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01032910124007.00454@neo> <20010329104710.A18159@devserv.devel.redhat.com> <0103291819180K.00454@neo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0103291819180K.00454@neo>; from k@ailis.de on Thu, Mar 29, 2001 at 06:19:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Reimer (k@ailis.de) said: 
> If I am doing this, I can't even load the module and I get the following 
> message in syslog:
> 
> 2001-03-29 18:13:14.184156500 {kern|err} kernel: opl3sa2: Control I/O port 
> 0x0 not free
> 
> What is that "control i/o port"? Is this normally 0x100?

I believe it can be, but I remember it usually being something
like 0x370 or so.

> What is the module 
> parameter to specify this io port? The documentation only mentions "io", 
> "mpu_io" and "mss_io" but I have specified these parameters already:
> 
> modprobe opl3sa2 io=0x538 mss_io=0x530 mpu_io=0x330 irq=5 dma=1 dma2=0 
> isapnp=0

It would be what you put in the io= parameter. 0x538 does *not* look
right.

Bill
