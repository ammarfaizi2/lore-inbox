Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbQLKUqy>; Mon, 11 Dec 2000 15:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLKUqs>; Mon, 11 Dec 2000 15:46:48 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:51079 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S130307AbQLKUqX>;
	Mon, 11 Dec 2000 15:46:23 -0500
Message-Id: <m145ZMP-000OWyC@amadeus.home.nl>
Date: Mon, 11 Dec 2000 21:15:45 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
cc: linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.21.0012111636040.4808-100000@duckman.distro.conectiva> <E145Xy6-0008HA-00@the-village.bc.nu>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E145Xy6-0008HA-00@the-village.bc.nu> you wrote:
>> Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
>> for the VM doesn't make any sense since it doesn't really excercise
>> the VM in any way...

> Its an interesting demo that 2.4 has some performance problems since 2.2
> is slower than 2.0 although nowdays not much.

Seems to depend on the hardware used. On my test box, 2.4 is faster by
0.3s....

Greetings,
    Arjan van de Ven

Machine:
AMD Duron 700Mhz with 128Mb of 133Mhz Ram
2 IBM 15Gb ATA100 disks in RAID0 raid

tested kernels:
2.2.18 + raid patch + latest IDE patch
2.4.0-test12pre7

compiling 2.2.18 with gcc 2.95.2

				1st run		2nd		3rd
kernel 2.2.18/raid/ide		3:28.909	3:28.819	3:28.840
kernel 2.4.0test12pre7		3:28:520	3:28.534	3:28.546

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
