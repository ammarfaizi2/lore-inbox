Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266603AbRG2WTU>; Sun, 29 Jul 2001 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRG2WTK>; Sun, 29 Jul 2001 18:19:10 -0400
Received: from sm1.texas.rr.com ([24.93.35.54]:13069 "EHLO mail.texas.rr.com")
	by vger.kernel.org with ESMTP id <S266220AbRG2WTB>;
	Sun, 29 Jul 2001 18:19:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
Date: Sun, 29 Jul 2001 16:50:35 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072916503504.04012@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The latest RH kernel, 2.4.3-12, works ok for us if we recompile with the 
explicit OSB4 support disabled and turn on UDMA2 manually with hdparm. The 
system stands up to continuous pounding with Bonnie and benchmarks at  
>20MB/sec for block reads (Tyan 2515). On the other hand, with the OSB4 
support turned on we see DMA timeouts immediately. I've just started some 
tests with OSB4 turned on in 2.4.7-ac2 and so far it seems ok.

On an unrelated topic the Serverworks LE chipset does not seem to be capable 
of handling 4GB of RAM, despite what the board vendors claim in their specs. 
When a 4th 1G stick is added the system gets really slow --- like maybe 
cacheing is disabled. We've seen this on both Tyan and SuperMicro boards. The 
HE chipset seems to be ok.

Marvin Justice
