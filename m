Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSIBDiL>; Sun, 1 Sep 2002 23:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318217AbSIBDiL>; Sun, 1 Sep 2002 23:38:11 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:37313 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318216AbSIBDiJ>;
	Sun, 1 Sep 2002 23:38:09 -0400
Message-ID: <1030938156.3d72de2c231ac@kolivas.net>
Date: Mon,  2 Sep 2002 13:42:36 +1000
From: Con Kolivas <conman@kolivas.net>
To: =?ISO-8859-1?B?RGlldGVyIE78dHplbA==?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
References: <200209020524.41937.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200209020524.41937.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dieter Nützel <Dieter.Nuetzel@hamburg.de>:

> I have your ck5_2.4.19.patch with some additional stuff running fine on my 
> dual Athlon MP 1900+, MSI K7D Master-L, 1 GB DDR-SDRAM 266 CL.

Great to hear. I'd be impressed if you noticed *any* change in responsiveness
with anything on that machine.

> ck5 + some 2.4.19-jam0 stuff (Andrea, Ingo, others)
> 
> 000_e100-2.1.6 (-AA)
> 000_e1000-4.3.2 (-AA)
> 00_387-fix-1
> 10-module-size-checks
> 12-memparam
> 24-config-nr_cpus
> 30-smptimers-A0
> 30_irq-balance-12
> 31-nr_requests
> 70-i2c-2.6.4
> 71-sensors-2.6.4
> 
> 2.4.19.pending ReiserFS stuff
> linux-2.4.19-ntfs-2.1.0a.patch
> page_color-2.4.19-pre10-1 (Page coloring)
> 
> I'm from Robert Love's "side" and have his stuff running on top of 2.4 for 
> nearly one year, now.
> 
> The first bench I try is latencytest-0.42-png all the time.
> http://www.gardena.net/benno/linux/audio/

That's a very nice test, but as you've seen, pure latency is not everything. If
you want just that you should try my ck5-ll patch which gives the lowest
latencies (check my website for the benchmarks on -ck4 which used this -ll branch).

> Then I try dbench (Yes, I know Rik ;-) to see the GREAT speed of Andrea 
> Arcangeli's -AA VM which improve noticeably with the Preemption patch.
> O(1) gave some additional speed, too.

Yes, dbench is included in the many tests available at the the Open Source
Development Lab (osdl.org) along with many others.

> What about Robert's nice Preemption Latency Measurement Tool?
> http://www.tech9.net/rml/linux

Once again a pure latency measure, no?

> I tried it many times to gave Robert some feedback.
> 
> Regards and good work!

Thanks, glad you enjoy it, but it's really the combined efforts of the real
developers as you know.

Thanks for your feedback
Con
