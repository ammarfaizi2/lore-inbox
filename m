Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130893AbRAOPKt>; Mon, 15 Jan 2001 10:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131013AbRAOPKj>; Mon, 15 Jan 2001 10:10:39 -0500
Received: from [216.29.39.226] ([216.29.39.226]:48646 "HELO
	mail.acetechnologies.net") by vger.kernel.org with SMTP
	id <S130893AbRAOPKY>; Mon, 15 Jan 2001 10:10:24 -0500
Message-ID: <3A6313CB.7020504@acetechnologies.net>
Date: Mon, 15 Jan 2001 10:14:19 -0500
From: Jeff McWilliams <Jeff.McWilliams@acetechnologies.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; 0.7) Gecko/20010109
X-Accept-Language: en
MIME-Version: 1.0
To: petkan@dce.bg
Cc: linux-kernel@vger.kernel.org
Subject: pegasus driver in 2.4.0, performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for supporting the pegasus USB chip under Linux.

I am using a Linksys Etherfast 10/100 USB network adapter on a Dell 
Inspiron 7000 laptop (Celeron 366, 128Megs of RAM, etc.)
Why? My 3COM PCMCIA network dongle got damaged recently so I've 
downgraded to this USB adapter for now.

I've observed that when using ftp, transferring a file from a server to 
the laptop with a 100Mb hub yields ~450Kbytes per second of throughput.  
Under Windows 2000 on the same hardware, same file, same ftp server, the 
transfer gets ~700Kbytes per second of throughput.  This is the only 
network speed benchmark I could think of, and seems to be a reasonable 
indicator of network performance.  Therefore, I'm assuming the 
performance observed under FTP applies to other network applications as 
well.

This is the only USB device connected to the laptop.
I know USB devices are currently very bandwidth limited due to the 
12Mbps specification of USB version 1. 
However, it seems that Windows 2000 is yielding significantly better 
performance from this adapter than Linux 2.4.0 is. 

Are there known performance problems under Linux with the pegasus chip 
and USB? 

Thanks,

Jeff mcWilliams

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
