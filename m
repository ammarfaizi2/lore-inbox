Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRAYLTD>; Thu, 25 Jan 2001 06:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131723AbRAYLSx>; Thu, 25 Jan 2001 06:18:53 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:62468 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S130241AbRAYLSj>; Thu, 25 Jan 2001 06:18:39 -0500
Date: Thu, 25 Jan 2001 14:07:00 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg from Systems <chandler@d2.com>
Cc: Peter Rival <frival@zk3.dec.com>, Richard Henderson <rth@twiddle.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Las message I promise...
Message-ID: <20010125140700.A5381@jurassic.park.msu.ru>
In-Reply-To: <20010124212104.A1294@jurassic.park.msu.ru> <Pine.SGI.4.10.10101242030170.29904-100000@hell.d2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SGI.4.10.10101242030170.29904-100000@hell.d2.com>; from chandler@d2.com on Wed, Jan 24, 2001 at 08:34:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 08:34:51PM -0800, Greg from Systems wrote:
> calypso 47# uname -a
> Linux calypso 2.4.0 #6 SMP Wed Jan 24 20:00:01 PST 2001 alpha unknown
                ^^^^^
...
 
> I used the patch at the bottom of this except for the part that patches:
> linux/include/asm-alpha/unistd.h

The part of the patch removing sys_wait4() definitions isn't needed
for kernels earlier than 2.4.1-pre10. In pre10 sys_wait4() defined
in include/linux/sched.h.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
