Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTFYXcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTFYXa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:30:58 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:52134 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265215AbTFYX3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:29:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.73-mm1 with contest
Date: Thu, 26 Jun 2003 09:45:46 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306260945.46212.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent contest benchmarks to compare with 2.5.73-mm1

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              1   79      94.9    0.0     0.0     1.00
2.5.72-mm1          1   78      93.6    0.0     0.0     1.00
2.5.72-mm2          1   77      94.8    0.0     0.0     1.00
2.5.73-mm1          1   77      94.8    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              1   76      98.7    0.0     0.0     0.96
2.5.72-mm1          1   74      98.6    0.0     0.0     0.95
2.5.72-mm2          1   75      97.3    0.0     0.0     0.97
2.5.73-mm1          1   75      98.7    0.0     0.0     0.97
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              2   107     70.1    65.0    28.7    1.35
2.5.72-mm1          2   107     68.2    65.0    29.0    1.37
2.5.72-mm2          2   108     67.6    66.5    28.7    1.40
2.5.73-mm1          2   108     67.6    67.0    29.6    1.40
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              3   103     75.7    0.0     0.0     1.30
2.5.72-mm1          3   107     72.0    0.7     3.7     1.37
2.5.72-mm2          3   105     73.3    1.0     5.7     1.36
2.5.73-mm1          3   103     74.8    0.0     0.0     1.34
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              3   104     74.0    1.0     3.8     1.32
2.5.72-mm1          3   113     66.4    2.0     4.4     1.45
2.5.72-mm2          3   118     63.6    2.0     4.2     1.53
2.5.73-mm1          3   113     66.4    2.0     4.4     1.47
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              4   356     21.9    128.9   19.3    4.51
2.5.72-mm1          4   122     62.3    43.8    18.7    1.56
2.5.72-mm2          4   119     63.0    44.1    20.0    1.55
2.5.73-mm1          4   127     59.1    39.7    16.5    1.65
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              2   120     65.0    51.2    23.0    1.52
2.5.72-mm1          2   112     67.9    44.5    19.5    1.44
2.5.72-mm2          2   111     68.5    44.6    19.6    1.44
2.5.73-mm1          2   112     67.9    43.0    19.6    1.45
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              2   104     75.0    6.3     4.8     1.32
2.5.72-mm1          2   104     74.0    7.7     6.7     1.33
2.5.72-mm2          2   106     71.7    7.7     8.5     1.38
2.5.73-mm1          2   100     76.0    7.8     7.0     1.30
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              2   97      79.4    0.0     7.2     1.23
2.5.72-mm1          2   93      80.6    0.0     6.5     1.19
2.5.72-mm2          2   93      80.6    0.0     5.4     1.21
2.5.73-mm1          2   93      80.6    0.0     7.5     1.21
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              2   95      82.1    54.0    2.1     1.20
2.5.72-mm1          2   111     69.4    53.5    1.8     1.42
2.5.72-mm2          2   111     69.4    53.5    1.8     1.44
2.5.73-mm1          2   114     68.4    54.0    1.8     1.48
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.72              4   397     19.6    5.5     50.4    5.03
2.5.72-mm1          4   333     22.5    4.2     44.7    4.27
2.5.72-mm2          4   328     22.6    4.5     48.0    4.26
2.5.73-mm1          4   365     20.8    5.0     48.2    4.74

Small differences only.

...so to answer your question Andrew, I don't see anything really showing up 
in this benchmark.

Con

