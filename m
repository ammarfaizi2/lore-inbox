Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSINSTq>; Sat, 14 Sep 2002 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSINSTq>; Sat, 14 Sep 2002 14:19:46 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:22665 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317400AbSINSTp>; Sat, 14 Sep 2002 14:19:45 -0400
Message-ID: <20020914182356.25570.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 15 Sep 2002 02:23:56 +0800
Subject: Re: System response benchmarks in performance patches
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <conman@kolivas.net>

> Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:
> 
> > [...]
> > >http://kernel.kolivas.net under the FAQ. A final >reminder note: it won't
> > work on
> > >2.5.x
> > 
> > Con, 
> > I think that only the _memload_ test is not
> > working with 2.5.*, am I wrong?
> 
> Correct. memload determines the amount of memory to allocate based on
> /proc/meminfo which has changed in 2.5.x
Rik has a pacth for this (thanks ;-).
Let me know when you are going to release a new version of the benchmark.
 
[...]
> P.S. How does 2.4.19-ck7 compare ;-)
Downloaded, compiled and tested ;-)
BTW, I tested also the latest compressed cache patch.

_NOLOAD_
Kernel		Time		CPU
2.4.19		7:37.99		99%
2.5.34		7:47.68		99%
2.4.19-0.24pre4	7:38.17		99%
2.4.19-ck7	7:35.54		99%

_CPULOAD_
Kernel		Time		CPU
2.4.19		9:07.80		82%
2.5.34		8:50.56		87%
2.4.19-0.24pre4	9:07.61		82%
2.4.19-ck7	8:38.07		87%

_IOLOAD_
Kernel		Time		CPU
2.4.19		11:23.86		65%
2.5.34		10:48.24		72%
2.4.19-0.24pre4	11:51.79		63%
2.4.19-ck7	10:41.56		71%

_MEMLOAD_
Kernel		Time		CPU
2.4.19		10:00.63	78%
2.5.34		[7:45.80]	[99%] 
2.4.19-0.24pre4	10:37.85	78%
2.4.19-ck7	10:46.06	72%

Ciao,
         Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
