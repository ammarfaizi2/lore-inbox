Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUCAVhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUCAVhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:37:14 -0500
Received: from web40612.mail.yahoo.com ([66.218.78.149]:11967 "HELO
	web40612.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261431AbUCAVhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:37:08 -0500
Message-ID: <20040301213706.82572.qmail@web40612.mail.yahoo.com>
Date: Mon, 1 Mar 2004 22:37:06 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: 2.6.4-rc1 problems with e100 & 3c59x
To: Steve Lee <steve@tuxsoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <005b01c3ffd3$54955140$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Steve Lee <steve@tuxsoft.com> a écrit : > I've searched the
archives as well as googled around without
> any luck
> regarding my situation.  BTW, please CC me as I'm no longer
> subscribed
> (furthering my education has prevented me from keeping up with
> the
> list).
> 
> Anyways, I have the following two network cards:
> 
> 02:04.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
> [Cyclone]
> (rev 30)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL
> 10/100
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         I/O ports at a000 [size=128]
>         Memory at fb025000 (32-bit, non-prefetchable)
> [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: <available only to root>
> 00: b7 10 55 90 07 00 10 02 30 00 00 02 08 20 00 00
> 10: 01 a0 00 00 00 50 02 fb 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 0a 0a
> 
> 02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet
> Pro 100]
> (rev 0d)
>         Subsystem: Intel Corp. EtherExpress PRO/100 Server
> Adapter
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         Memory at fb024000 (32-bit, non-prefetchable)
> [size=4K]
>         I/O ports at ac00 [size=64]
>         Memory at fb000000 (32-bit, non-prefetchable)
> [size=128K]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: <available only to root>
> 00: 86 80 29 12 07 00 90 02 0d 00 00 02 08 20 00 00
> 10: 00 40 02 fb 01 ac 00 00 00 00 00 fb 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 42 10
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 08 38
> 
> Using 2.4.x (including the latest stable), I've had no trouble
> getting
> these cards to work as modules.  However, when I upgraded to
> 2.6.0 I
> couldn't get them to work as modules, but finally tried
> compiling them
> into the kernel and all was well until 2.6.4-rc1.  Now, no
> matter what I
> do, compiled in or as modules, I can not get both cards
> working.
> 

did you upgraded from modutils to module-init-tools ?

> 
> Please help!  (Please CC me)
> 
> Thanks,
> Steve
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout ! 
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
