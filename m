Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbSIZM2B>; Thu, 26 Sep 2002 08:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbSIZM2B>; Thu, 26 Sep 2002 08:28:01 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:46011 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262507AbSIZM17>;
	Thu, 26 Sep 2002 08:27:59 -0400
Message-ID: <1033043594.3d92fe8a8dd82@kolivas.net>
Date: Thu, 26 Sep 2002 22:33:14 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.38-mm3 with contest 0.37
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are the contest results (http://contest.kolivas.net) for 2.5.38-mm3:

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  72.21           99%             1.00
2.5.38                  73.56           99%             1.02
2.5.38-mm2              73.88           99%             1.02
2.5.38-mm3              74.10           99%             1.03

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  88.02           80%             1.22
2.5.38                  77.44           94%             1.07
2.5.38-mm2              77.88           94%             1.08
2.5.38-mm3              77.94           94%             1.08

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  170.06          45%             2.36
2.5.38                  283.27          28%             3.92
2.5.38-mm2              106             75%             1.47*
2.5.38-mm3              95.9            84%             1.33*

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  100.52          78%             1.39
2.5.38                  116.94          67%             1.62
2.5.38-mm2              105             74%             1.45  
2.5.38-mm3              109             73%             1.50

IO load and mem_load results are averages of n=5 runs. The difference between
io_loads of mm2 and mm3 is statistically significant (p=0.022) but not mem_load.

Con.


P.S. For those who just want more info :-P

Hardware: 1133Mhz PIII, 256Mb Ram, IDE ATA5 5400rpm HD, IO load on same disk,
reiserFS


Statistics assuming normal distribution curve:

mm2:
Hi = 126. Low = 92.1
Mean = 106.
95% confidence interval for Mean: 87.52 thru 124.6
Standard Deviation = 14.9
Median = 103.
Average Absolute Deviation from Median = 11.5

mm3:
Hi = 107. Low = 82.1
Mean = 95.9
95% confidence interval for Mean: 80.51 thru 111.4
Standard Deviation = 12.4
Median = 101.
Average Absolute Deviation from Median = 9.64
