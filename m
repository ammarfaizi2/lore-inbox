Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283693AbRK3QFH>; Fri, 30 Nov 2001 11:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283694AbRK3QE6>; Fri, 30 Nov 2001 11:04:58 -0500
Received: from [138.15.150.16] ([138.15.150.16]:34579 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S283693AbRK3QEm>;
	Fri, 30 Nov 2001 11:04:42 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15367.44557.930845.66428@abasin.nj.nec.com>
Date: Fri, 30 Nov 2001 11:04:29 -0500 (EST)
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
In-Reply-To: <20011130114506.A4789@bee.lk>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com>
	<20011129095107.A17457@conwaycorp.net>
	<3C070FEC.3602CB49@pobox.com>
	<20011130114506.A4789@bee.lk>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have eepro100's on other systems and never had a problem.  They
never have been made to work as hard as the DELLs though.  I am
trying the same DELL with a 3C996-T 1000Bt card using the driver from
3COM (we plan on moving that system to a 1000Bt system but the switch
hasn't arrived yet) and it is running at 100Bt with the same
software.  If you don't hear form me assume it surrived.  Been up a
day so far, took the DELL like 3 days of heavy use to crash before.

	   Sven

 > Has anybody got the same issue with non Dell machines?
 > 
 > I am running 2.4.16 on a Compaq proliant ML 370 without problems (machine has
 > been up for 2+ days with the new kernels, though).  Trafic is not very high.
 > 
 > The driver is built into the kernel.
 > 
 > /proc/pci shows
 > 
 >   Bus  0, device   2, function  0:
 >     Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 8).
 >       IRQ 5.
 >       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
 >       Non-prefetchable 32 bit memory at 0xc4fff000 [0xc4ffffff].
 >       I/O at 0x2400 [0x243f].
 >       Non-prefetchable 32 bit memory at 0xc4e00000 [0xc4efffff].
 >   Bus  0, device   5, function  0:
 >     Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (#2) (rev 8).
 >       IRQ 10.
 >       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
 >       Non-prefetchable 32 bit memory at 0xc4dfd000 [0xc4dfdfff].
 >       I/O at 0x2c00 [0x2c3f].
 >       Non-prefetchable 32 bit memory at 0xc4c00000 [0xc4cfffff].
 > 
 > Regards,
 > 
 > Anuradha
 > 
 > -- 
 > 
 > Debian GNU/Linux (kernel 2.4.16)
 > 
 > First Law of Bicycling:
 > 	No matter which way you ride, it's uphill and against the wind.
 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
