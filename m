Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271964AbRIDMor>; Tue, 4 Sep 2001 08:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271960AbRIDMog>; Tue, 4 Sep 2001 08:44:36 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:23783 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S271961AbRIDMo2>; Tue, 4 Sep 2001 08:44:28 -0400
Subject: CPU context corrupt?
From: Aquila <aquila@hypox.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 04 Sep 2001 22:33:08 +1000
Message-Id: <999606788.1571.12.camel@hamlet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have had this problem quite a while now: when playing tribes2 or when
a particular CPU intensive xscreensaver is running, X would often hang.
I used to be able to ssh from another box or use SysRq-K to kill X and
restart (but I never figured out what the problem was).

Ever since upgrading to 2.4.9-ac3 (from 2.4.8-ac5 I believe), whenever
it hangs in X the computer would beep and give this message in syslog:

Sep  4 21:43:41 hamlet kernel: CPU 0: Machine Check Exception:
0000000000000004
Sep  4 21:43:41 hamlet kernel: Bank 1: f600200000000152 at
7600200000000152
Sep  4 21:43:41 hamlet kernel: Bank 2: d40040000000017a at
540040000000017a
Sep  4 21:43:41 hamlet kernel: Kernel panic: CPU context corrupt

It hangs there, and SysRq-K is no longer able to kill X properly. sshd
stops working as well. What does this message mean? Do I have faulty
hardware? 

My CPU is an Athlon 1.2Ghz, not overclocked. Any ideas what's wrong?

Thanks,
Aq.


