Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSJLXM6>; Sat, 12 Oct 2002 19:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJLXM6>; Sat, 12 Oct 2002 19:12:58 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:4481 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261372AbSJLXM4>; Sat, 12 Oct 2002 19:12:56 -0400
Message-ID: <20021012231841.8863.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 13 Oct 2002 07:18:41 +0800
Subject: [Benchmark] Contest 0.51
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here the contest results:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              128.8   97      0       0       1.01
2.5.40 [3]              134.4   96      0       0       1.05
2.5.40-nopree [3]       133.7   96      0       0       1.04
2.5.41 [3]              136.5   96      0       0       1.07
2.5.41-mm2 [3]          134.8   96      0       0       1.05
2.5.42 [3]              134.8   96      0       0       1.05
2.5.42-mm2 [3]          135.5   96      0       0       1.06

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              194.1   60      134     40      1.52
2.5.40 [3]              184.5   70      53      31      1.44
2.5.40-nopree [3]       286.4   45      163     55      2.24
2.5.41 [3]              192.6   68      59      32      1.50
2.5.41-mm2 [3]          193.4   66      68      34      1.51
2.5.42 [3]              187.6   68      58      32      1.46
2.5.42-mm2 [3]          186.0   69      60      31      1.45

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              461.0   28      46      8       3.60
2.5.40 [3]              293.6   45      25      8       2.29
2.5.40-nopree [3]       269.4   50      20      7       2.10
2.5.41 [3]              342.7   41      34      9       2.68
2.5.41-mm2 [3]          251.1   54      21      8       1.96
2.5.42 [3]              304.5   45      28      9       2.38
2.5.42-mm2 [3]          254.6   53      20      8       1.99

It seems useful to me add a colum with CPU%+LCPU%.
It is intersting to notice that 2.5.41 spend 41+9=50% CPU time 
for compiling and for the io_load while 2.5.42 spend 45+9=54% 
time. Can I say that 2.5.42 is "better" than 2.5.41 ?

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [3]              162.3   82      10      4       1.27
2.5.42-mm2 [3]          162.5   82      10      4       1.27

No difference here.

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.42 [3]              154.2   85      0       6       1.20
2.5.42-mm2 [3]          155.1   85      0       6       1.21

No difference here.

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              161.1   80      38      2       1.26
2.5.40 [3]              163.0   80      34      2       1.27
2.5.40-nopree [3]       161.7   80      34      2       1.26
2.5.41 [3]              161.0   83      33      2       1.26
2.5.41-mm2 [3]          229.9   57      35      1       1.80
2.5.42 [3]              157.9   83      33      2       1.23
2.5.42-mm2 [3]          162.2   81      33      2       1.27

No difference here.


Comments ?

		Paolo
		
		
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
