Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSJJUnx>; Thu, 10 Oct 2002 16:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264002AbSJJUnx>; Thu, 10 Oct 2002 16:43:53 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:57274 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264001AbSJJUnt>; Thu, 10 Oct 2002 16:43:49 -0400
Message-ID: <20021010204929.30332.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: conman@kolivas.net
Date: Fri, 11 Oct 2002 04:49:28 +0800
Subject: [Benchmark] Contest 0.50 against 2.5.41-mm2
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here the results of Contest 0.50 against 2.5.41-mm2
I hope it is helps...

$ cat /cygdrive/log/results.log

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              128.8   97      0       0       1.02
2.4.19-0.24pre4 [3]     127.4   98      0       0       1.01
2.5.40 [3]              134.4   96      0       0       1.07
2.5.40-nopree [3]       133.7   96      0       0       1.06
2.5.41 [3]              136.5   96      0       0       1.08
2.5.41-mm2 [3]          134.8   96      0       0       1.07

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              194.1   60      134     40      1.54
2.5.40 [3]              184.5   70      53      31      1.46
2.5.40-nopree [3]       286.4   45      163     55      2.27
2.5.41 [3]              192.6   68      59      32      1.53
2.5.41-mm2 [3]          193.4   66      68      34      1.53

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              461.0   28      46      8       3.66
2.5.40 [3]              293.6   45      25      8       2.33
2.5.40-nopree [3]       269.4   50      20      7       2.14
2.5.41 [3]              342.7   41      34      9       2.72
2.5.41-mm2 [3]          251.1   54      21      8       1.99

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              161.1   80      38      2       1.28
2.5.40 [3]              163.0   80      34      2       1.29
2.5.40-nopree [3]       161.7   80      34      2       1.28
2.5.41 [3]              161.0   83      33      2       1.28
2.5.41-mm2 [3]          229.9   57      35      1       1.82

Ciao,
          Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
