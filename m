Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276554AbRI2RE2>; Sat, 29 Sep 2001 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276555AbRI2RES>; Sat, 29 Sep 2001 13:04:18 -0400
Received: from mailb.telia.com ([194.22.194.6]:26129 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S276554AbRI2REF>;
	Sat, 29 Sep 2001 13:04:05 -0400
Message-ID: <3BB5FF17.B316A969@canit.se>
Date: Sat, 29 Sep 2001 19:04:23 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with IDE DMA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide_dmaproc: chipset supported ide_dma_timeout func only: 14

I get alot of this both with 2.4.10 and 2.4.9-ac17. This results in dma getting turned off and a slow disk.

The way to reproduce it is running "find . -type f |xargs wc >/dev/null" and wait a while. I have so far tested a few different configured kernels and never once completed the above command on a 30GB filesystem without getting the hd to drop out of dma.

I have two disk one on the motherboard IDE and one on a promise ultra66. Both have the same problem.

-- 
Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 2)

Promise Technology, Inc. 20262 (rev 1)

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 6
