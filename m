Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSHOFbU>; Thu, 15 Aug 2002 01:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSHOFbU>; Thu, 15 Aug 2002 01:31:20 -0400
Received: from ip-208-252-253-53-muca.asurf.net ([208.252.253.53]:40068 "EHLO
	bedevere.spamaps.org") by vger.kernel.org with ESMTP
	id <S316578AbSHOFbT>; Thu, 15 Aug 2002 01:31:19 -0400
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
From: Clint Byrum <cbyrum@spamaps.org>
To: Meelis Roos <mroos@cs.ut.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029389331.20774.17.camel@lancelot>
References: <1029389331.20774.17.camel@lancelot>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Aug 2002 22:35:04 -0700
Message-Id: <1029389705.21173.31.camel@lancelot>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Things got stranger. The symptoms started to appear on other connections
> too (slashdot web for example). TCP bad packet count increased and no
> success was made. I did a reboot with the same kernel (2.4.19+bk of some
> state, 4. Aug probably) and it just started to work with the same kernel
> image.
> 

I am seeing this exact same problem on 2.4.18+ipsec+grsecurity, though
mine is on an Intel NIC..

eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:1E:41:4D, IRQ 10.
eth0      Link encap:Ethernet  HWaddr 00:02:B3:1E:41:4D  
          inet addr:10.30.3.2  Bcast:10.30.3.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:110268 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4613 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:26566206 (25.3 MiB)  TX bytes:430171 (420.0 KiB)
          Interrupt:10 

This box was up for about 15 days without problems, and then started
exhibiting this behavior of not seeing SYNACK's. Though this was
happening to me on all attempts at making an outgoing TCP connection. My
tcpdump was nearly identical to your earlier post. I rebooted it, and it
has not had any problems with outgoing connections since(a whole 6
hours).

> Now I will test and see if the symptoms appear again after some days.
> 

That is where I am at too. If worst comes to worst, I will break out the
memtest86 disk and see if it is in fact bad RAM causing this stuff.


btw... I am not subscribed to lkml, so please CC: me on any replies to
this. Thanks. :)


