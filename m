Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131251AbRACW0I>; Wed, 3 Jan 2001 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRACWZ6>; Wed, 3 Jan 2001 17:25:58 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:29966 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130032AbRACWZW>; Wed, 3 Jan 2001 17:25:22 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Wed, 3 Jan 2001 15:25:06 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: scole@lanl.gov
Subject: Yet more benchmarks for 2.4.0-prerelease and -ac[4,5]
MIME-Version: 1.0
Message-Id: <01010315250600.01807@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran dbench 48 four times in  succession for the following
recent kernels.  It looks like there may be a slight drop
in performance for -ac5.  For -ac4 and -ac5, the throughput
dropped on run #3.  That's probably just a fluke.  I'll repeat
these runs later when I get a chance.

This was performed with a Dell 420 dual P-III ( 256 MB, 733 MHz), with a
ST317221A ATA DISK drive and ReiserFS 3.6.23. Each test was
done under the same conditions, running KDE 2.0, one xterm,
right after booting.  My script did not wait between runs.

2.4.0-prerelease:     average 10.9536 MB/sec

Throughput 11.1771 MB/sec (NB=13.9714 MB/sec  111.771 MBit/sec)
Throughput 10.7172 MB/sec (NB=13.3965 MB/sec  107.172 MBit/sec)
Throughput 10.8443 MB/sec (NB=13.5554 MB/sec  108.443 MBit/sec)
Throughput 11.0758 MB/sec (NB=13.8447 MB/sec  110.758 MBit/sec)


2.4.0-prerelease-ac4: average 11.4729 MB/sec

Throughput 11.4646 MB/sec (NB=14.3307 MB/sec  114.646 MBit/sec)
Throughput 13.3765 MB/sec (NB=16.7206 MB/sec  133.765 MBit/sec)
Throughput 9.81891 MB/sec (NB=12.2736 MB/sec  98.1891 MBit/sec)
Throughput 11.2315 MB/sec (NB=14.0393 MB/sec  112.315 MBit/sec)


2.4.0-prerelease-ac5: average  9.2181 MB/sec

Throughput 9.18921 MB/sec (NB=11.4865 MB/sec  91.8921 MBit/sec)
Throughput 9.06864 MB/sec (NB=11.3358 MB/sec  90.6864 MBit/sec)
Throughput 7.69499 MB/sec (NB=9.61874 MB/sec  76.9499 MBit/sec)
Throughput 10.9196 MB/sec (NB=13.6495 MB/sec  109.196 MBit/sec)

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
