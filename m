Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRATRWL>; Sat, 20 Jan 2001 12:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRATRWB>; Sat, 20 Jan 2001 12:22:01 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:46015 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S129884AbRATRVs>; Sat, 20 Jan 2001 12:21:48 -0500
Message-ID: <3A69CA51.DE979641@att.net>
Date: Sat, 20 Jan 2001 12:26:41 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Maas <dmaas@dcine.com>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694357.1A7C6AAC@att.net> <01da01c082c5$2c155e60$0701a8c0@morph>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> 
> What kernel have you been using? I have reproduced your problem on a
> standard 2.2.18 kernel (elapsed time ~10sec). However, using a 2.4.0 kernel
> with HZ=1000, I see a 100x improvement (elapsed time ~0.1 sec; note that
> increasing HZ alone should only give a 10x improvement). Perhaps the
> scheduler was fixed in 2.4.0?

Sounds like a good reason for me to upgrade - I am running 2.2.18 now.
If it's fixed in 2.4.0, then I'm happy (although I'm usually leery of
installing ANYTHING that ends in ".0", Linux has never been anything
less than stable). It sounds like there are some other anomalies this
tickles that might bear looing into, though.

Thanks for all the help, and again, my apologies for posting a lame-o
test program with the original report - had I taken the time to make a
test program that REALLY exercised the problem as described, I would
have saved you all a lot of time.

--
Mike Lindner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
