Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCOXu1>; Thu, 15 Mar 2001 18:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRCOXuR>; Thu, 15 Mar 2001 18:50:17 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:1800 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S129245AbRCOXuB>; Thu, 15 Mar 2001 18:50:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2and 8139too
In-Reply-To: <Pine.LNX.4.21.0103151527420.2382-100000@ve1drg.com>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 16 Mar 2001 10:49:14 +1100
In-Reply-To: <Pine.LNX.4.21.0103151527420.2382-100000@ve1drg.com>
Message-ID: <84u24ufv9h.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ted" == Ted Gervais <ve1drg@ve1drg.com> writes:

    Ted> A simple question for you guru's..  I just installed kernel
    Ted> 2.4.2 on a slackware system and have a problem with loading a
    Ted> module. It is the 8139too.o module previously the rtl8139.o.
    Ted> It seems that this new driver is not being loaded with this
    Ted> new kernel. Obviously something has changed but I can't seem
    Ted> to see where that is.  I noticed though that the directories
    Ted> in /lib/modules for this kernel is different than 2.2.18.

Sorry, this is not related to your problem...

However, I have just put a 8139 based card into my Linux 2.4.2
system. At one stage, these lines were logged:

Mar 15 09:42:56 snoopy kernel: eth0: Abnormal interrupt, status 00000020.
Mar 15 09:43:04 snoopy kernel: eth0: Abnormal interrupt, status 00002020.
Mar 15 10:06:52 snoopy kernel: eth0: Abnormal interrupt, status 00000020.
Mar 15 10:06:58 snoopy kernel: eth0: Abnormal interrupt, status 00002020.

The card seems to be reliable apart from these messages. It could be
that I was playing around with the network cable or something at the
time... However, any messages "Abnormal interrupt" make me slightly
nervous.

Anyway, further information:

Mar 14 16:10:22 snoopy kernel: 8139too Fast Ethernet driver 0.9.13 loaded
Mar 14 16:10:22 snoopy kernel: PCI: Found IRQ 12 for device 00:0a.0
Mar 14 16:10:22 snoopy kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xc8800000, 00:48:54:1d:b2:85, IRQ 12
Mar 14 16:10:22 snoopy kernel: eth0:  Identified 8139 chip type 'RTL-8139C'

[...]

Mar 14 16:10:23 snoopy kernel: eth0: Setting full-duplex based on MII #32 link partner ability of 45e1.

(sorry if this problem has already been reported...)
-- 
Brian May <bam@snoopy.apana.org.au>
