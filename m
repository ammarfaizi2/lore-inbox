Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131796AbRCaArB>; Fri, 30 Mar 2001 19:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRCaAqv>; Fri, 30 Mar 2001 19:46:51 -0500
Received: from umail.unify.com ([204.163.170.2]:57596 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S131796AbRCaAqn>;
	Fri, 30 Mar 2001 19:46:43 -0500
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C169@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: tulip (was RE: Kernel 2.4.3 fails to compile)
Date: Fri, 30 Mar 2001 16:42:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> > It looks like the tulip driver isn't as up-to-date as the one from
> > 2.4.2-ac20 - when is 2.4.3-ac1 due? :-) I got NETDEV 
> WATCHDOG errors shortly
> > after rebooting with 2.4.3, although these were of the 
> "slow/packet lossy"
> > type I got with 2.4.2-ac20 instead of the "network 
> completely unusable" type
> > I got with 2.4.2-ac11 and earlier.
> 
> I'm betting that the latest ac (ac28?) is broken for you, too.
> 
> I had to revert the changes in 'ac' tulip -- they fixed Comet 
> and 21041
> cards, but broke some others.  sigh.
> 
> sigh.  More testing and debugging for Jeffro...  Comet (your chip, I
> am guessing?) should be fixed ASAP, it's pretty easy.  21041 is not as
> easy, but should be fixed quickly as well.

Yes, mine is a Comet - here's the exact detection message:

Mar 30 13:09:06 ulthar kernel: Linux Tulip driver version 0.9.14 (February
20, 2
001)
Mar 30 13:09:06 ulthar kernel: PCI: Found IRQ 5 for device 00:0c.0
Mar 30 13:09:06 ulthar kernel: eth0: ADMtek Comet rev 17 at 0xb000,
00:20:78:0D:
D2:E1, IRQ 5.

I must say that I really appreciate the effort that all of the kernel
developers put in...

Thanks,
--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."
