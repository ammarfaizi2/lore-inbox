Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRLLO5S>; Wed, 12 Dec 2001 09:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbRLLO5I>; Wed, 12 Dec 2001 09:57:08 -0500
Received: from zeus.hjc.edu.sg ([203.127.28.34]:31411 "HELO zeus.hjc.edu.sg")
	by vger.kernel.org with SMTP id <S280537AbRLLO47>;
	Wed, 12 Dec 2001 09:56:59 -0500
To: linux-kernel@vger.kernel.org
Subject: AACRAID & Kernel-2.4.17-pre8
Message-ID: <1008169010.3c1770320ed43@home.hjc.edu.sg>
Date: Wed, 12 Dec 2001 22:56:50 +0800 (SGT)
From: Chen Shiyuan <csy@hjc.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Hwa Chong Junior College Mail System (CMS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After applying patch-2.4.17-pre8 on the stock kernel-2.4.16 and 
recompiling with AACRAID enabled and rebooting, all goes well except for 
the tons and tons of the following messages which appears whenever I 
typed DMESG at the shell prompt. The machine in question is a dual CPU 
Dell PowerEdge 2550 with an AACRAID controller in place.

Does anyone know how to get rid of these messages or are they indicative 
of some bugs in the system?

Many thanks in advance for any advice or help.

(please CC: replies to me as I am not subscribed to the list)

---

aachba: received a write(10) command on target 0.
aac_write[cpu 1]: lba = 2228737, t = 189543.
fib_send: inserting a queue entry at index 161.
Fib contents:.
  Command =               500.
  XferState  =            830ad.
write_callback[cpu 1]: lba = 34, t = 189543.
aachba: received a write(10) command on target 0.
aac_write[cpu 1]: lba = 2228753, t = 189543.
fib_send: inserting a queue entry at index 162.
Fib contents:.
  Command =               500.
  XferState  =            830ad.
write_callback[cpu 0]: lba = 34, t = 189543.
aachba: received a write(10) command on target 0.
aac_write[cpu 0]: lba = 2228761, t = 189614.
fib_send: inserting a queue entry at index 163.
Fib contents:.
  Command =               500.
  XferState  =            830ad.
write_callback[cpu 0]: lba = 34, t = 189614.
aachba: received a write(10) command on target 0.
aac_write[cpu 0]: lba = 2228849, t = 189614.
fib_send: inserting a queue entry at index 164.
Fib contents:.
  Command =               500.
  XferState  =            830ad.
write_callback[cpu 1]: lba = 34, t = 189614.
