Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263822AbSJHUzr>; Tue, 8 Oct 2002 16:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263816AbSJHUzq>; Tue, 8 Oct 2002 16:55:46 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:3740 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263818AbSJHUz0>; Tue, 8 Oct 2002 16:55:26 -0400
Message-ID: <20021008205955.4860.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 09 Oct 2002 04:59:55 +0800
Subject: [Benchmark] Contest 0.50
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
hw is a HP Omnibook600, PIII@800 256MiB of RAM.
File system s ext3

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19-0.24pre4 [3]     127.4   98      0       0       0.99
2.4.19 [3]              128.8   97      0       0       1.01
2.5.40 [3]              134.4   96      0       0       1.05
2.5.40-nopree [3]       133.7   96      0       0       1.04
2.5.41 [3]              136.5   96      0       0       1.07

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19-0.24pre4 [3]     193.2   60      133     40      1.51
2.4.19 [3]              194.1   60      134     40      1.52
2.5.40 [3]              184.5   70      53      31      1.44
2.5.40-nopree [3]       286.4   45      163     55      2.24
2.5.41 [3]              192.6   68      59      32      1.50

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19-0.24pre4 [3]     235.4   55      26      10      1.84
2.4.19 [3]              461.0   28      46      8       3.60
2.5.40 [3]              293.6   45      25      8       2.29
2.5.40-nopree [3]       269.4   50      20      7       2.10
2.5.41 [3]              342.7   41      34      9       2.68

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19-0.24pre4 [3]     181.2   76      253     19      1.41
2.4.19 [3]              161.1   80      38      2       1.26
2.5.40 [3]              163.0   80      34      2       1.27
2.5.40-nopree [3]       161.7   80      34      2       1.26
2.5.41 [3]              161.0   83      33      2       1.26

Ciao,
           Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
