Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTEKGk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 02:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTEKGk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 02:40:56 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:42183 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264601AbTEKGky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 02:40:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.69-mm3 with contest
Date: Sun, 11 May 2003 16:55:35 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305111655.35543.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   79      94.9    0.0     0.0     1.00
2.5.68-mm1          2   79      94.9    0.0     0.0     1.00
2.5.68-mm2          1   80      93.8    0.0     0.0     1.00
2.5.68-mm3          1   80      93.8    0.0     0.0     1.00
2.5.69              1   80      93.8    0.0     0.0     1.00
2.5.69-mm3          1   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   75      100.0   0.0     0.0     0.95
2.5.68-mm1          1   75      100.0   0.0     0.0     0.95
2.5.68-mm2          1   76      98.7    0.0     0.0     0.95
2.5.68-mm3          1   76      98.7    0.0     0.0     0.95
2.5.69              1   76      98.7    0.0     0.0     0.95
2.5.69-mm3          1   76      98.7    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   181     40.9    193.3   57.5    2.29
2.5.68-mm1          2   178     41.6    191.5   56.7    2.25
2.5.68-mm2          2   177     41.8    177.5   56.5    2.21
2.5.68-mm3          2   177     42.4    181.5   55.9    2.21
2.5.69              2   181     41.4    196.5   58.0    2.26
2.5.69-mm3          2   176     42.0    183.0   56.2    2.23
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   105     74.3    0.0     0.0     1.33
2.5.68-mm1          3   112     69.6    1.0     5.3     1.42
2.5.68-mm2          3   108     73.1    1.0     5.6     1.35
2.5.68-mm3          3   120     66.7    1.0     5.0     1.50
2.5.69              3   103     75.7    0.0     0.0     1.29
2.5.69-mm3          3   126     63.5    1.0     4.8     1.59
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   105     72.4    1.0     3.8     1.33
2.5.68-mm1          3   108     71.3    1.0     4.6     1.37
2.5.68-mm2          3   107     72.0    1.0     4.7     1.34
2.5.68-mm3          3   111     69.4    1.7     4.5     1.39
2.5.69              3   106     72.6    1.0     3.7     1.32
2.5.69-mm3          3   111     69.4    1.7     4.5     1.41
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   492     15.9    167.1   19.7    6.23
2.5.68-mm1          4   128     59.4    47.6    19.4    1.62
2.5.68-mm2          4   131     58.8    47.0    18.9    1.64
2.5.68-mm3          4   271     28.4    89.2    17.9    3.39
2.5.69              4   343     22.7    120.5   19.8    4.29
2.5.69-mm3          4   319     24.5    105.3   18.1    4.04
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   148     52.7    65.7    25.0    1.87
2.5.68-mm1          2   117     66.7    48.9    22.0    1.48
2.5.68-mm2          2   120     65.0    49.2    22.3    1.50
2.5.68-mm3          2   127     61.4    45.1    19.5    1.59
2.5.69              2   127     61.4    55.5    24.4    1.59
2.5.69-mm3          2   133     58.6    47.1    18.7    1.68
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   109     71.6    6.2     4.6     1.38
2.5.68-mm1          2   115     68.7    9.1     6.1     1.46
2.5.68-mm2          2   115     67.8    9.1     6.1     1.44
2.5.68-mm3          2   117     67.5    9.2     6.0     1.46
2.5.69              2   104     75.0    6.3     4.8     1.30
2.5.69-mm3          2   113     69.9    9.1     6.1     1.43
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   95      81.1    0.0     5.3     1.20
2.5.68-mm1          2   96      79.2    0.0     7.3     1.22
2.5.68-mm2          2   97      79.4    0.0     7.2     1.21
2.5.68-mm3          2   96      80.2    0.0     7.3     1.20
2.5.69              2   95      81.1    0.0     5.3     1.19
2.5.69-mm3          2   95      81.1    0.0     7.4     1.20
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   113     69.0    64.3    1.8     1.43
2.5.68-mm1          2   98      79.6    53.0    2.0     1.24
2.5.68-mm2          2   101     78.2    53.0    2.0     1.26
2.5.68-mm3          2   130     61.5    75.0    2.3     1.62
2.5.69              2   98      79.6    60.5    2.0     1.23
2.5.69-mm3          2   135     59.3    77.0    2.2     1.71
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   412     18.4    5.3     47.6    5.22
2.5.68-mm1          4   361     21.1    5.5     54.0    4.57
2.5.68-mm2          4   345     22.0    4.8     49.3    4.31
2.5.68-mm3          4   721     10.5    6.8     33.6    9.01
2.5.69              4   374     20.3    5.0     48.1    4.67
2.5.69-mm3          4   653     11.6    6.2     34.0    8.27

Very similar to 2.5.68-mm3

Con
