Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbTGIKjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbTGIKjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:39:09 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:36315 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S268157AbTGIKi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:38:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.74-mm3 with contest
Date: Wed, 9 Jul 2003 20:55:12 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307092055.12739.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://contest.kolivas.org results with http://www.osdl.org hardware

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              1   79      93.7    0.0     0.0     1.00
2.5.74-mm1          1   79      94.9    0.0     0.0     1.00
2.5.74-mm2          1   77      96.1    0.0     0.0     1.00
2.5.74-mm3          1   79      93.7    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              1   75      98.7    0.0     0.0     0.95
2.5.74-mm1          1   76      98.7    0.0     0.0     0.96
2.5.74-mm2          1   75      98.7    0.0     0.0     0.97
2.5.74-mm3          1   75      98.7    0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              2   109     67.9    65.0    28.4    1.38
2.5.74-mm1          2   106     69.8    60.0    28.3    1.34
2.5.74-mm2          2   104     71.2    55.5    26.0    1.35
2.5.74-mm3          2   107     69.2    64.0    29.0    1.35
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              3   104     75.0    0.0     0.0     1.32
2.5.74-mm1          3   109     72.5    1.0     5.5     1.38
2.5.74-mm2          3   111     72.1    1.0     5.4     1.44
2.5.74-mm3          3   110     72.7    1.0     6.4     1.39
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              3   106     72.6    1.0     3.8     1.34
2.5.74-mm1          3   123     61.8    2.0     4.8     1.56
2.5.74-mm2          3   107     71.0    1.7     4.7     1.39
2.5.74-mm3          3   105     72.4    1.0     4.8     1.33
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              4   331     23.9    117.5   18.7    4.19
2.5.74-mm1          4   122     63.1    44.6    19.7    1.54
2.5.74-mm2          4   163     47.2    59.9    20.1    2.12
2.5.74-mm3          4   154     50.0    55.9    20.1    1.95
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              2   121     64.5    50.8    22.1    1.53
2.5.74-mm1          2   118     65.3    51.2    24.6    1.49
2.5.74-mm2          2   115     67.0    46.5    22.4    1.49
2.5.74-mm3          2   117     65.8    46.4    21.4    1.48
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              2   104     76.0    6.6     4.8     1.32
2.5.74-mm1          2   106     74.5    8.3     6.6     1.34
2.5.74-mm2          2   103     75.7    8.2     5.8     1.34
2.5.74-mm3          2   105     74.3    8.5     6.7     1.33
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              2   97      79.4    0.0     7.2     1.23
2.5.74-mm1          2   94      81.9    0.0     7.4     1.19
2.5.74-mm2          2   96      80.2    0.0     7.3     1.25
2.5.74-mm3          2   95      81.1    0.0     7.4     1.20
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              2   97      80.4    59.5    2.0     1.23
2.5.74-mm1          2   99      79.8    51.5    2.0     1.25
2.5.74-mm2          2   102     76.5    58.5    2.0     1.32
2.5.74-mm3          2   99      79.8    59.0    2.0     1.25
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.74              4   334     23.1    5.0     52.7    4.23
2.5.74-mm1          4   255     30.2    5.0     42.0    3.23
2.5.74-mm2          4   386     19.9    6.5     54.9    5.01
2.5.74-mm3          4   308     25.0    4.2     49.2    3.90

Small changes. The rise in io_load and dbench_load has been blunted a little 
by the O3int modifications.

Con

