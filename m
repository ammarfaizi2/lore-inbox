Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261272AbRELPq5>; Sat, 12 May 2001 11:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbRELPqq>; Sat, 12 May 2001 11:46:46 -0400
Received: from [203.237.41.93] ([203.237.41.93]:21898 "EHLO verdi.kjist.ac.kr")
	by vger.kernel.org with ESMTP id <S261272AbRELPql>;
	Sat, 12 May 2001 11:46:41 -0400
Date: Sun, 13 May 2001 00:44:45 +0900
Message-Id: <200105121544.f4CFijp26537@verdi.kjist.ac.kr>
From: root <root@verdi.kjist.ac.kr>
To: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: correctable ECC error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On UP2000 SMP with two 21264 CPU's running 2.4.5pre1aa1 and 2.2.19aa1,
I am getting the following message:

===================================================

May 12 07:02:09 norma kernel: TSUNAMI machine check: vector=0x630 pc=0x20001170070 code=0x100000086
May 12 07:02:09 norma kernel: machine check type: correctable ECC error (retryable)
May 12 07:02:16 norma init: PANIC: segmentation violation! sleeping for 30 seconds.
May 12 07:02:46 norma init: PANIC: segmentation violation! sleeping for 30 seconds.
May 12 07:03:46 norma last message repeated 2 times
May 12 07:04:46 norma last message repeated 2 times
May 12 07:05:46 norma last message repeated 2 times
May 12 07:06:46 norma last message repeated 2 times
May 12 07:07:46 norma last message repeated 2 times
May 12 07:08:46 norma last message repeated 2 times
May 12 07:09:46 norma last message repeated 2 times
May 12 07:10:46 norma last message repeated 2 times
May 12 07:11:47 norma last message repeated 2 times
May 12 07:12:47 norma last message repeated 2 times
May 12 07:13:47 norma last message repeated 2 times
May 12 07:14:47 norma last message repeated 2 times
May 12 07:15:47 norma last message repeated 2 times
May 12 07:16:47 norma last message repeated 2 times
May 12 07:17:47 norma last message repeated 2 times
May 12 07:18:47 norma last message repeated 2 times
May 12 07:19:47 norma last message repeated 2 times
May 12 07:20:47 norma last message repeated 2 times
May 12 07:21:47 norma last message repeated 2 times
May 12 07:22:47 norma last message repeated 2 times
May 12 07:23:47 norma last message repeated 2 times
May 12 07:24:47 norma last message repeated 2 times
May 12 07:25:47 norma last message repeated 2 times
May 12 07:26:47 norma last message repeated 2 times
May 12 07:27:47 norma last message repeated 2 times
May 12 07:28:47 norma last message repeated 2 times
May 12 07:29:47 norma last message repeated 2 times
May 12 07:30:47 norma last message repeated 2 times
May 12 07:31:47 norma last message repeated 2 times
May 12 07:32:47 norma last message repeated 2 times
May 12 07:33:47 norma last message repeated 2 times
May 12 07:34:47 norma last message repeated 2 times
May 12 07:35:47 norma last message repeated 2 times
May 12 07:36:47 norma last message repeated 2 times
May 12 07:37:47 norma last message repeated 2 times
May 12 07:38:47 norma last message repeated 2 times
May 12 07:39:47 norma last message repeated 2 times
May 12 07:40:47 norma last message repeated 2 times
May 12 07:41:47 norma last message repeated 2 times
May 12 07:42:47 norma last message repeated 2 times
May 12 07:43:47 norma last message repeated 2 times
May 12 07:44:47 norma last message repeated 2 times
May 12 07:45:47 norma last message repeated 2 times
May 12 07:46:47 norma last message repeated 2 times
May 12 07:47:47 norma last message repeated 2 times
May 12 07:48:47 norma last message repeated 2 times
May 12 07:49:48 norma last message repeated 2 times
May 12 07:50:48 norma last message repeated 2 times
May 12 07:51:48 norma last message repeated 2 times
May 12 07:52:48 norma last message repeated 2 times
May 12 07:53:48 norma last message repeated 2 times
May 12 07:54:48 norma last message repeated 2 times
May 12 07:55:48 norma last message repeated 2 times
May 12 07:56:48 norma last message repeated 2 times
May 12 07:57:48 norma last message repeated 2 times
May 12 07:58:48 norma last message repeated 2 times
May 12 07:59:48 norma last message repeated 2 times
May 12 08:00:48 norma last message repeated 2 times
May 12 08:01:48 norma last message repeated 2 times
May 12 08:02:48 norma last message repeated 2 times
May 12 08:03:48 norma last message repeated 2 times
May 12 08:04:48 norma last message repeated 2 times
May 12 08:05:48 norma last message repeated 2 times
May 12 08:06:48 norma last message repeated 2 times
May 12 08:07:48 norma last message repeated 2 times
May 12 08:08:48 norma last message repeated 2 times
May 12 08:09:48 norma last message repeated 2 times
May 12 08:10:48 norma last message repeated 2 times
May 12 08:11:48 norma last message repeated 2 times
May 12 08:12:48 norma last message repeated 2 times
May 12 08:13:48 norma last message repeated 2 times
May 12 08:14:48 norma last message repeated 2 times
May 12 08:15:48 norma last message repeated 2 times
May 12 08:16:48 norma last message repeated 2 times
May 12 08:17:48 norma last message repeated 2 times
May 12 08:18:48 norma last message repeated 2 times
May 12 08:19:48 norma last message repeated 2 times
May 12 08:20:48 norma last message repeated 2 times
May 12 08:21:48 norma last message repeated 2 times


==================================================

Is one of my memory modules failiing?  BTW, it did not sleep when 
I used 2.4.2.  The message with 2.4.2 was like this:

====================================================

May  5 00:23:43 norma kernel: TSUNAMI machine check: vector=0x630 pc=0x20001174e7c code=0x100000086
May  5 00:23:44 norma kernel: machine check type: correctable ECC error (retryable)
May  5 00:23:44 norma kernel: pc = [<0000020001174e7c>]  ra = [<000002002af92010>]  ps = 0008
May  5 00:23:44 norma kernel: v0 = 00000000000000c8  t0 = 00000200497dc010  t1 = 0000020086a00000
May  5 00:23:44 norma kernel: t2 = 00000000002dc6c0  t3 = 0000020086a54600  t4 = 0000020086a52e80
May  5 00:23:44 norma kernel: t5 = 000002004aedd110  t6 = 000002004aedc550  t7 = 000002004aedcb90
May  5 00:23:44 norma kernel: a0 = 0000000000000064  a1 = 0000000000000004  a2 = 00000000000000c8
May  5 00:23:44 norma kernel: a3 = 0000000000000000  a4 = 000000000000003f  a5 = 0000000000000058
May  5 00:23:44 norma kernel: t8 = 0000000000000080  t9 = 0000000000003a98  t10= 0000000000000000
May  5 00:23:44 norma kernel: t11= 00000200497dc010  pv = 0000020086a00000  at = 0000020086a19000

===============================================================

Kernel gurus,
Is this behavior all familiar to you?  If so, please tell me whether 
my memory is failing or not.  During the initial machine check before 
the SRM console prompt, I get Memory OK all the time.

I apologize if this article is off-topic.

Thank you very much.

G. Hugh Song

ghsong at kjist dot ac dot kr

