Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSHLKKn>; Mon, 12 Aug 2002 06:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317755AbSHLKKn>; Mon, 12 Aug 2002 06:10:43 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:60871 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S317653AbSHLKKm>;
	Mon, 12 Aug 2002 06:10:42 -0400
Date: Mon, 12 Aug 2002 13:14:22 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: "David S. Miller" <davem@redhat.com>
cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
In-Reply-To: <20020812.025453.114975744.davem@redhat.com>
Message-ID: <Pine.GSO.4.43.0208121310280.10696-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aparently something is wrong with the checksums.
> InErrs gets incremented in three cases:
>
> 1) Header too small, unlikely what you see
>
> 2) Bad SYN sequences, Abort On Syn in TcpExt would have been
>    incremented also if this were the case, it was not
>
> 3) Bad TCP checksum
>
> Hmmm, do you have messages that say "hw tcp v4 csum failed"
> in your kernel logs?  Any other interesting kernel messages?

Nothing interesting at all in my kernel logs.

eth1: RealTek RTL8139 Fast Ethernet at 0xd88ad000, 00:c0:df:04:7f:9b, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139B'

eth1      Link encap:Ethernet  HWaddr 00:C0:DF:04:7F:9B
          inet addr:62.128.97.170  Bcast:255.255.255.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:556705 errors:0 dropped:0 overruns:0 frame:0
          TX packets:410116 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:581410743 (554.4 MiB)  TX bytes:32798898 (31.2 MiB)
          Interrupt:10 Base address:0xd000

-- 
Meelis Roos (mroos@linux.ee)

