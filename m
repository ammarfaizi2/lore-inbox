Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132771AbRC2QXn>; Thu, 29 Mar 2001 11:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRC2QXZ>; Thu, 29 Mar 2001 11:23:25 -0500
Received: from malcolm.ailis.de ([62.159.58.30]:27917 "HELO malcolm.ailis.de")
	by vger.kernel.org with SMTP id <S132770AbRC2QWe>;
	Thu, 29 Mar 2001 11:22:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Klaus Reimer <k@ailis.de>
Organization: Ailis
To: Bill Nottingham <notting@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Date: Thu, 29 Mar 2001 18:19:18 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01032910124007.00454@neo> <20010329104710.A18159@devserv.devel.redhat.com>
In-Reply-To: <20010329104710.A18159@devserv.devel.redhat.com>
MIME-Version: 1.0
Message-Id: <0103291819180K.00454@neo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > 2001-03-29 10:02:50.054774500 {kern|info} kernel: ad1848/cs4248 codec
> > driver Copyright (C) by Hannu Savolainen 1993-1996
> > 2001-03-29 10:02:50.070692500 {kern|notice} kernel: opl3sa2: No cards
> > found 2001-03-29 10:02:50.070703500 {kern|notice} kernel: opl3sa2: 0 PnP
> > card(s) found.
> Add 'isapnp=0' to the end of the options in your modules.conf.
> I *believe* this is fixed in a later kernel (2.4.3pre or 2.4.2ac).

If I am doing this, I can't even load the module and I get the following 
message in syslog:

2001-03-29 18:13:14.184156500 {kern|err} kernel: opl3sa2: Control I/O port 
0x0 not free

What is that "control i/o port"? Is this normally 0x100? What is the module 
parameter to specify this io port? The documentation only mentions "io", 
"mpu_io" and "mss_io" but I have specified these parameters already:

modprobe opl3sa2 io=0x538 mss_io=0x530 mpu_io=0x330 irq=5 dma=1 dma2=0 
isapnp=0

-- 
Bye, K
[a735 47ec d87b 1f15 c1e9 53d3 aa03 6173 a723 e391]
(Finger k@ailis.de to get public key)
