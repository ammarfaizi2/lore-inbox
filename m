Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310502AbSCCDC4>; Sat, 2 Mar 2002 22:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310503AbSCCDCr>; Sat, 2 Mar 2002 22:02:47 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:43393 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S310502AbSCCDCm>; Sat, 2 Mar 2002 22:02:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.19-pre2-ac2 + preempt + lock-break
Date: Sun, 3 Mar 2002 04:02:32 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203030402.32814.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I am now running quite nicely your latest stuff..;-)
It feels GREAT.
But the throughput at least on my system is somewhat lower than with my latest 
-aa VM (vm_25) kernel 2.4.18-pre8-K3-VM-24-preempt-lock.

I am going to compare "your" version against
2.4.19-pre2
vm_28
read-latency2
O(1)-K3	(the hardest part)
preempt + lock-break	(got that but not Ingo's stuff then)
2.4.18.pending ReiserFS stuff

All OOM problems are fixed with vm_28 for me.
I've checked it with and without swap.
With former versions some system tasks (smpppd), kdeinit and desktop processes 
(xperfmon++, kpanel, kmail, kalarm, etc.) were falsely killed.

With 2.4.19-pre2-ac2 + pre and without swap (I disabled it before running the 
"test" prog) kswapd (?) goes into 20~25% system time usage and the whole 
system gets unusable. I had to reboot...

X have to be reniced -10 to get smooth mouse movement under both kernels 
(Ingo's part) during compilations (bzlilo).

Regards,
	Dieter

BTW Some numbers will follow when I get O(1) + preempt going with 2.4.19-pre2 
+ vm_28.


