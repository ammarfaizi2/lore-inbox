Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136157AbRARWwm>; Thu, 18 Jan 2001 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136176AbRARWwW>; Thu, 18 Jan 2001 17:52:22 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:29863 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S136175AbRARWwS>; Thu, 18 Jan 2001 17:52:18 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Thu, 18 Jan 2001 15:52:01 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
MIME-Version: 1.0
Message-Id: <01011815520101.01097@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Marcelo Tosatti wrote:
> On my dbench runs I've noted a slowdown between pre4 and pre8 with 48
> threads. (128MB, 2 CPU's machine)

I ran dbench 48 four times in succession for 2.4.0 and 2.4.1-pre8.
The change in performance appears to be not significant.

This was performed with a Dell 420 dual P-III (733 MHz), with a ST317221A, 
ATA DISK drive and ReiserFS 3.6.25. 

Each test was done under the same conditions, running KDE 2.0, one xterm, 
right after booting.  

2.4.0:
Average    9.07868 MB/sec

Throughput 9.03546 MB/sec (NB=11.2943 MB/sec  90.3546 MBit/sec)
Throughput 8.99614 MB/sec (NB=11.2452 MB/sec  89.9614 MBit/sec)
Throughput 8.87756 MB/sec (NB=11.097 MB/sec  88.7756 MBit/sec)
Throughput 9.40556 MB/sec (NB=11.7569 MB/sec  94.0556 MBit/sec)

2.4.1-pre8:
Average    9.25707 MB/sec

Throughput 8.93444 MB/sec (NB=11.1681 MB/sec  89.3444 MBit/sec)
Throughput 9.43609 MB/sec (NB=11.7951 MB/sec  94.3609 MBit/sec)
Throughput 9.5075 MB/sec (NB=11.8844 MB/sec  95.075 MBit/sec)
Throughput 9.15026 MB/sec (NB=11.4378 MB/sec  91.5026 MBit/sec)

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
