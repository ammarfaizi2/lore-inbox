Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310228AbSCBBQX>; Fri, 1 Mar 2002 20:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310231AbSCBBQO>; Fri, 1 Mar 2002 20:16:14 -0500
Received: from DIRTY-BASTARD.MIT.EDU ([18.241.0.136]:5248 "EHLO
	dirty-bastard.pthbb.org") by vger.kernel.org with ESMTP
	id <S310238AbSCBBQD>; Fri, 1 Mar 2002 20:16:03 -0500
Message-Id: <200203021329.g22DTNW00880@dirty-bastard.pthbb.org>
To: linux-kernel@vger.kernel.org
Subject: Tulip bug?
Date: Sat, 02 Mar 2002 08:29:23 -0500
From: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I upgraded to 2.4.16 shortly after it was released and have since
experienced quasi-periodic kernel panics (every few weeks). I have tested
my memory and while I got a few faults after several hours this panic
behavior is not what I (perhaps erroneously) would expect from faulty memory
instigated kernel panics. I've also run 2.4.17 and also get kernel panics.

Yesterday I noticed something in the panic spew (it's hard to notice
much as more than a screenful is output, why is that? It seems to be
counterproductive.)

  eth0: Internal fault the skbuff addresses do not match in tulip_rx: 00000010
  vs. 077f8010 c77f8000/c77f8010

I have a Netgear Fastgear 310TX and compiled in the tulip and old DECChip
modules (it didn't seem to work with just tulip).

PS> Please (b)cc as I am not subscribed
