Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRGSQEo>; Thu, 19 Jul 2001 12:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRGSQEd>; Thu, 19 Jul 2001 12:04:33 -0400
Received: from mail.spylog.com ([194.67.35.220]:19688 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S263748AbRGSQEV>;
	Thu, 19 Jul 2001 12:04:21 -0400
Date: Thu, 19 Jul 2001 20:06:18 +0400
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.52f)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <59-1589488063.20010719200618@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages X-order allocation failed.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello linux-kernel,

  I'm trying to get stable running kernel from 2.4 series for about 3
  months now, I thought it should become stable up to this time but it
  still not at least in VM area.

  I'm Testing various kernels from  Linus, Alan, Andrea as well as
  some other patches provided but still:  I have no kernel which runs
  stable - I always have __alloc_pages errors in kernel logs and after
  while system completely dies with different things.

  I have about 30 systems I try to kernel start to work. They contain
  1-2GB of memory, some of them are SMP. Some have swapping on
  software raid1, which I thought is the reason, but it's not even
  putting swap on a raw partition does not help.

  Traces show quit different places for __alloc_pages to fail there is
  really NO out of memory condition - several hundreds of megabytes
  are in cache.

  The main purpose for these systems is MYSQL database.

  So I'm asking if there is any way to make kernel running more
  stable?

  May be some workarounds exists - For example may be I can increase
  number of reserved buffers and so on ?

-- 
Best regards,
 Peter                          mailto:pz@spylog.ru

