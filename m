Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131075AbRAWUe7>; Tue, 23 Jan 2001 15:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRAWUej>; Tue, 23 Jan 2001 15:34:39 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:51485 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131625AbRAWUeb>; Tue, 23 Jan 2001 15:34:31 -0500
From: "LA Walsh" <law@sgi.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: 2.4 cpu usage...
Date: Tue, 23 Jan 2001 12:32:55 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHMEDDCKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided put 2.4 on my laptop.  After getting config issues seemingly
sorted out, still have some things I can't explain.  VMware seems to run
about 30% slower.  X was even sluggish at times.  When I'm doing 'nothing',
top shows about 67% IDLE and 30% in 'system time'.  I notice that
the process "kapm-idled" is being counted as receiving alot of CPU time.
Now this could make some sense maybe that idled is getting 30% of the time,
but then there's the remaining 67% that came up idle.

I shut down X -- then top showed 5% idle and 95% in "kapm-idled"  (and
95% system time) which could still make sense but is probably not the output
you want to see when your computer is really idle.

So the kapm thing could be a "display" / accounting problem, but the
slowdown in vmware/X was real.  I ran a WIN Norton "Benchmark" -- comes
up reliably over "300" -- usually around 320-350 under 2.2.17.  Under
2.4, it came up reliably *under* 300 with typical being about 265".

So...I'm bummed.  I'm assuming a 30% degradation in an app is probably
not expected behavior?  Swap usage is '0' in both OS's (i.e. it's not
a run out of memory issue).

-l

--
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice/Vmail: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
