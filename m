Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269824AbRHET6G>; Sun, 5 Aug 2001 15:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHET55>; Sun, 5 Aug 2001 15:57:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269824AbRHET5s>; Sun, 5 Aug 2001 15:57:48 -0400
Subject: Re: Problems with 2.4.7-ac6 + SMP + FastTrak100
To: arnvid@karstad.org (Arnvid Karstad)
Date: Sun, 5 Aug 2001 20:59:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010805210628.B856.ARNVID@karstad.org> from "Arnvid Karstad" at Aug 05, 2001 09:23:21 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TU3v-0008HH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I rebuilt my kernel 2.4.7 after applied Alan Cox patch 6 to get FastTrak
> 100 support in my kernel. The kernel boots fine up until after it's
> freeing memory used by kernel with the following printout..
> 
> 
> Freeing unused kernel memory: 236kbytes
> Invalid operand: 0000
> CPU:0
> EIP: 0010:[<c010ca24>]
> EFALGS: 00010206
> ... then all the registers

If yo can grab the EIP and the calltrace after the thunderstorm, then look
them up in System.map that would be great. Also see if disabling pnpbios
support helps
