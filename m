Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSIEPcl>; Thu, 5 Sep 2002 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSIEPcl>; Thu, 5 Sep 2002 11:32:41 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:53644 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317520AbSIEPcj>; Thu, 5 Sep 2002 11:32:39 -0400
Message-ID: <20020905153709.29686.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: venom@sns.it, <ahu@ds9a.nl>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 05 Sep 2002 23:37:09 +0800
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: venom@sns.it
 
> I usually run byte bench regularly with every new kernel, so I see some
> strange results here.
> 
> From your numbers, I would say you are using a PIII 600/900 Mhz (more or
> less). It is not an AMD AThlon or a PIV, since float and double are too
> slow, not it is a K6 because they are too fast.
Yes, I ran the test on a HP Omnibook 600 (PIII@900)
 
[...]
> seeing this I think you had something running in background using your CPU
> while you where running int tests. if you loock at bm/results/log
> (log.accum if you did some other run recently)
> should find lines like:
> 
> Arithmetic Test (type = int)|10.0|lps|227163.1|227158.7|6
> 
> that is a little more interesting if you are under load.
No other load, just top and a less of a few files.
 
[...]
> > >Process Creation Test                     9078.6 lps       5422.1 lps
> > Execl Throughput Test                       998.0 lps        771.6 lps
> 
> this is interesting, but seeing previous results about int and short,
> I am curious about your real load. I am quite curious if with 2.5 you are
> using kernel preemption.
No load, but preemption.
 
> > File Read  (10 seconds)                 1571652.0 KBps   1553289.0 KBps
> > File Write (10 seconds)                  109237.0 KBps    132002.0 KBps
> > >File Copy  (10 seconds)                  24329.0 KBps     17994.0 KBps
> > File Read  (30 seconds)                 1562505.0 KBps   1540682.0 KBps
> > File Write (30 seconds)                  113152.0 KBps    137781.0 KBps
> > File Copy  (30 seconds)                   14334.0 KBps     11460.0 KBps
> 
> I saw the save with IDE disks... again, are you using kernel preemption?
ang again, yes ;-)

> > C Compiler Test                             470.9 lpm        450.9 lpm
> > Shell scripts (1 concurrent)                980.4 lpm        876.7 lpm
> > Shell scripts (2 concurrent)                544.1 lpm        480.3 lpm
> > Shell scripts (4 concurrent)                287.0 lpm        251.0 lpm
> > Shell scripts (8 concurrent)                147.0 lpm        126.0 lpm
> 
> In my tests generally shell scripts are faster with 2.5 kernel.

In any case I'll run again the test with the 4.1 version of Unix Bench.
I'll post the result using as "baseline" the results of the 2.4.19 again 2.5.33 and hopefully 2.4.20-pre5aa1.

Ciao,
         Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
