Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131872AbQKCU6t>; Fri, 3 Nov 2000 15:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131856AbQKCU6d>; Fri, 3 Nov 2000 15:58:33 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131651AbQKCU6S>;
	Fri, 3 Nov 2000 15:58:18 -0500
Message-ID: <20001103195546.A119@bug.ucw.cz>
Date: Fri, 3 Nov 2000 19:55:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: celeron-class misdetected as 486 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.4.0-test10, I get

pavel@bug:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 4
model           : 0
model name      : 486 DX-25/33
stepping        : 0
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : no
cpuid level     : 3
wp              : yes
use_tsc         : no


.... that's wrong. Older kernels detect it correctly as:

May 10 21:39:04 bug kernel: Pentium-III serial number disabled.
May 10 21:39:04 bug kernel: CPU: Intel Celeron (Mendocino) stepping 0a

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
