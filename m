Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQLaD1S>; Sat, 30 Dec 2000 22:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135774AbQLaD1I>; Sat, 30 Dec 2000 22:27:08 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:31248 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130643AbQLaD06>; Sat, 30 Dec 2000 22:26:58 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: test13-pre7...
Date: Sat, 30 Dec 2000 19:57:58 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.10.10012301237570.1300-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012301237570.1300-100000@penguin.transmeta.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00123019575800.01541@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like 2.4.0-test13-pre7 is a clear winner when running dbench 48
on my somewhat slow test machine (450 Mhz P-III, 192MB, IDE).

2.2.18                3.53307 MB/sec (NB=4.41633 MB/sec  35.3307 MBit/sec)
2.2.19-pre3           3.81213 MB/sec (NB=4.76516 MB/sec  38.1213 MBit/sec)
2.4.0-test13-pre5     4.06823 MB/sec (NB=5.08529 MB/sec  40.6823 MBit/sec)
2.4.0-test13-pre6     4.11353 MB/sec (NB=5.14192 MB/sec  41.1353 MBit/sec)
2.4.0-test13pre4-ac2  4.47376 MB/sec (NB=5.5922  MB/sec  44.7376 MBit/sec)
2.4.0-test13-pre7     6.3723  MB/sec (NB=7.96538 MB/sec  63.723  MBit/sec)

The tests were done under identical conditions, after fresh boot-up,
running KDE 2.0, one xterm, and xosview.

Here are a few selected lines from dmesg to put things in perspective.

Detected 448.810 MHz processor.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: ST317221A, ATA DISK drive
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.23

This is really looking great.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
