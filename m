Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSIORBh>; Sun, 15 Sep 2002 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318128AbSIORBh>; Sun, 15 Sep 2002 13:01:37 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:15077 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318122AbSIORBd>; Sun, 15 Sep 2002 13:01:33 -0400
Message-ID: <20020915170622.5444.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <conman@kolivas.net>, linux-kernel@vger.kernel.org
Date: Mon, 16 Sep 2002 01:06:22 +0800
Subject: Re: Revealing benchmarks and new version of contest.
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <conman@kolivas.net>
[...]
> Below are the new benchmarks with these loads:
Con, 
I have different results:

_NOLOAD_
Kernel		Time		CPU
2.4.19		2:04.34		99%
2.4.19-ck7	2:03.70		99%
2.4.19-0.24pre4	2:03.81		99%
2.5.34		2:07.24		99%

_CPULOAD_
Kernel		Time		CPU
2.4.19		2:27.98		81%
2.4.19-ck7	2:19.14		87%
2.4.19-0.24pre4	2:27.56		81%
2.5.34		2:22.09		88%

_MEMLOAD_
Kernel		Time		CPU
2.4.19		2:50.46		74%
2.4.19-ck7	2:34.80		80%
2.4.19-0.24pre4	2:59.07		77%
2.5.34		3:11.77		67%

_IOLOADHALF_ (compressed cache kerenel is the winner)
Kernel		Time		CPU
2.4.19		6:12.45		33%
2.4.19-ck7	9:35.92		21%
2.4.19-0.24pre4	3:55.21		53%
2.5.34		8:08.52		26%

_IOLOADFULL_
(Compressed Cache Kernel is the winner)
(I stopped 2.5.34 after 2 hours!!!, hard reboot needed)
Kernel		Time		CPU
2.4.19		6:45.87		31%
2.4.19-ck7	16:45.95	12%
2.4.19-0.24pre4	3:16.63		63%

2.5.34 is preemption ON
HW is a HP omnibook6000, 256 MiB RAM, PIII@800

Ciao,
          Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
