Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRKMUjZ>; Tue, 13 Nov 2001 15:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278813AbRKMUjP>; Tue, 13 Nov 2001 15:39:15 -0500
Received: from mail.myrio.com ([63.109.146.2]:52467 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S278810AbRKMUjM>;
	Tue, 13 Nov 2001 15:39:12 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAC3@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Roy Sigurd Karlsbakk'" <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Cc: lars.nakkerud@compaq.com
Subject: RE: Tuning Linux for high-speed disk subsystems
Date: Tue, 13 Nov 2001 12:38:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> After some testing at Compaq's lab in Oslo, I've come to the 
> conclusion
> that Linux cannot scale higher than about 30-40MB/sec in or out of a
> hardware or software RAID-0 set with several stripe/chunk 
> sizes tried out.

Hmmm. I saw "dbench 32" results of 73 MB / second using Linux
software RAID-0 and IDE.  However, I suppose some of that 
was due to caching, and not hardware throughput.

Details: 2.4.9-ac17, 4 x Maxtor 5400 RPM, 60 GB hard drives, 
2 x Promise TX-2 controllers, using UDMA-100, one drive / cable,
dual PIII-800, reiserfs, RAID - 0 with chunk-size = 1024

Torrey



