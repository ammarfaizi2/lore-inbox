Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274815AbRJJFSc>; Wed, 10 Oct 2001 01:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJJFSN>; Wed, 10 Oct 2001 01:18:13 -0400
Received: from eunhasu.kjist.ac.kr ([203.237.32.200]:24551 "EHLO
	eunhasu.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S274806AbRJJFSE>; Wed, 10 Oct 2001 01:18:04 -0400
Message-ID: <3BC3DA1E.6060806@kjist.ac.kr>
Date: Wed, 10 Oct 2001 14:18:22 +0900
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Idle bug net yet solved in 2.4.11-pre6(aa1)
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized that
since around 2.4.10-pre8aa1, I have been having the idle-bug trouble which
have been actively addressed at the moment.

In patch-2.4.11.log file, I was able to find:

Under pre6
- Peter Rival: update alpha SMP bootup to match wait_init_idle fixes

Apparently, it has not been fixed even in 2.4.11-pre6(aa1).
"top" showed the idle percentage upsurdly high around 10^8 %.
Then the machine freezed completely.

Configuration:
SuSE-7.1 (for alpha) running on UP2000 SMP with 2GB main memory.
5GB swap space all together in three hard disks.
Reasonably high mem usage which does not actually need any
swap space.

I am now using 2.2.20pre9aa2. I have not had much luck with
2.4 kernels yet. Every time I tried 2.4 kernels, I have had all
those vm-related troubles. I sincerely hope that the situation will soon
be corrected all together. Then, we can say linux-2.4 is truly 2.4 (even
numbered version).


Best regards,

G. Hugh Song


