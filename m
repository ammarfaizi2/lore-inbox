Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280942AbRKCLUT>; Sat, 3 Nov 2001 06:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280943AbRKCLT6>; Sat, 3 Nov 2001 06:19:58 -0500
Received: from mail009.syd.optusnet.com.au ([203.2.75.170]:37263 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S280942AbRKCLTy>; Sat, 3 Nov 2001 06:19:54 -0500
Message-Id: <200111031119.fA3BJoJ10824@mail009.syd.optusnet.com.au>
Content-Type: text/plain; charset=US-ASCII
From: Nero <neroz@dingoblue.net.au>
To: linux-kernel@vger.kernel.org
Subject: mb/s oddness between linus kernel & ac
Date: Sat, 3 Nov 2001 22:18:44 +1100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry if this was sent twice]

Hi, I recently tried out both kernels to see the difference between
hdparm -t tests, and the results are disturbing.
Both kernels are configured the same, heres the results:

Linus kernel 2.4.14pre4:
/dev/hda:
 Timing buffered disk reads:  64 MB in  1.59 seconds = 40.25 MB/sec
AC kernel 2.4.13ac5:
/dev/hda:
 Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec

I checked that both had the same settings [with hdparm -v /dev/hda]
The hdd is a seagate 60gig 7200rpm ide, & chipset is via kt133a
If more hardware info is needed, let me know.
