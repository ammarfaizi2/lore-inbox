Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270012AbRHEU6M>; Sun, 5 Aug 2001 16:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270013AbRHEU6B>; Sun, 5 Aug 2001 16:58:01 -0400
Received: from redbull.speedroad.net ([195.139.232.25]:26376 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S270012AbRHEU5v>; Sun, 5 Aug 2001 16:57:51 -0400
Date: Sun, 05 Aug 2001 22:55:58 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problems with 2.4.7-ac6 + SMP + FastTrak100
Cc: arnvid@karstad.org (Arnvid Karstad), linux-kernel@vger.kernel.org
In-Reply-To: <E15TU3v-0008HH-00@the-village.bc.nu>
In-Reply-To: <20010805210628.B856.ARNVID@karstad.org> <E15TU3v-0008HH-00@the-village.bc.nu>
Message-Id: <20010805224817.B859.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Aug 2001 20:59:47 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I rebuilt my kernel 2.4.7 after applied Alan Cox patch 6 to get FastTrak
> > 100 support in my kernel. The kernel boots fine up until after it's
> > freeing memory used by kernel with the following printout..
> > 
> > 
> > Freeing unused kernel memory: 236kbytes
> > Invalid operand: 0000
> > CPU:0
> > EIP: 0010:[<c010ca24>]
> > EFALGS: 00010206
> > ... then all the registers
> 
> If yo can grab the EIP and the calltrace after the thunderstorm, then look
> them up in System.map that would be great. Also see if disabling pnpbios
> support helps


I tried to both disable the pnpbios in the config but it didn't help

EIP 0010:[<c010c764>]
Process swapper : (pid: 0, stackspace c0279000)
CALLTRACE
[<c01057c2>][<c0112d1e>][<c01051b0>][<c010501b0>][<c010524e>][<c0105000>][<c0105043>]

Can't really seem to find any of this in system.map .. but I'm prolly
looking wrong =)

