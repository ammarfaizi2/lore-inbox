Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280047AbRJaDkJ>; Tue, 30 Oct 2001 22:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280048AbRJaDkA>; Tue, 30 Oct 2001 22:40:00 -0500
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:52405 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280047AbRJaDjl>; Tue, 30 Oct 2001 22:39:41 -0500
Date: Tue, 30 Oct 2001 22:40:11 -0500
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac2 weird vm stats
Message-ID: <20011030224011.A32651@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noticed this while in x. shortly afterwards (less than a minute), the stats
returned to normal, except it was reporting little to no, or possible still
negative cache (couldn't tell at the time, was reading from xosview). the
vmstat output below may have been generated just after it returned to
normal.

 10:20pm  up 4 days, 35 min,  1 user,  load average: 2.47, 2.18, 2.06
51 processes: 49 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  0.6% user,  0.2% system, 99.0% nice,  0.0% idle
Mem:  510296K av, 506208K used,   4088K free,      0K shrd, 139728K buff
Swap:  98272K av,      0K used,  98272K free                 -9552K cached

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  1      0 127368 131792   3248   0   0     1     6   11     8   3   0   0


Linux zero 2.4.13-ac2 #1 Fri Oct 26 22:24:29 EDT 2001 alpha unknown

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
