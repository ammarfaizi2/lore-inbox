Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbQKGEpE>; Mon, 6 Nov 2000 23:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbQKGEoz>; Mon, 6 Nov 2000 23:44:55 -0500
Received: from c837140-a.vncvr1.wa.home.com ([65.0.81.146]:34308 "EHLO
	cyclonehq.dnsalias.net") by vger.kernel.org with ESMTP
	id <S130599AbQKGEoj>; Mon, 6 Nov 2000 23:44:39 -0500
Date: Mon, 6 Nov 2000 20:45:03 -0800 (PST)
From: Dan Browning <danb@cyclonehq.dnsalias.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [HARDLOCK] 2.2.17 locks up hard on Ultra66/PDC20262 in DMA mode
 when using ide + raid-A0 + eepro100 patches (fwd)
Message-ID: <Pine.LNX.4.21.0011062044280.11597-100000@cyclonehq.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far I have hit 25 minutes of uptime, another few hours to go.

I noticed a few errors in dmesg, though:
VFS: Disk change detected on device ide0(3,64)

And while the system is running I thought I might as well run iozone (an
IO benchmarking tool good for hard drives).

Additionally, I have gotten the following from hdparm -T /dev/md0...
/dev/md0:
 Timing buffer-cache reads:   128 MB in  1.39 seconds = 92.09 MB/sec

92MB/sec... not bad for $425 of hardware. (I love Linux).

On Mon, 6 Nov 2000, Andre Hedrick wrote:

> 
> Fsn shake this at it...
> 
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
