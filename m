Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTIAGT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTIAGT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:19:56 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:15004
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262640AbTIAGTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:19:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.6.0-test4-mm4 with contest
Date: Mon, 1 Sep 2003 16:27:28 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011627.28052.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

contest benchmarks.

no_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          1  80      93.8    0.0     0.0     1.00
2.6.0-test4-mm2      1  79      93.7    0.0     0.0     1.00
2.6.0-test4-mm4      1  80      93.8    0.0     0.0     1.00
cacherun:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          1  75      100.0   0.0     0.0     0.94
2.6.0-test4-mm2      1  75      98.7    0.0     0.0     0.95
2.6.0-test4-mm4      1  77      97.4    0.0     0.0     0.96
process_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          2  108     69.4    64.0    28.7    1.35
2.6.0-test4-mm2      2  125     59.2    92.5    38.4    1.58
2.6.0-test4-mm4      2  131     56.5    104.5   41.2    1.64
ctar_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          3  117     67.5    1.0     5.1     1.46
2.6.0-test4-mm2      3  115     69.6    1.0     6.1     1.46
2.6.0-test4-mm4      3  99      80.8    0.0     0.0     1.24
xtar_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          3  132     58.3    3.0     7.5     1.65
2.6.0-test4-mm2      3  141     54.6    3.3     7.0     1.78
2.6.0-test4-mm4      3  109     70.6    1.0     3.7     1.36
io_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          4  119     64.7    43.4    19.2    1.49
2.6.0-test4-mm2      4  110     70.0    35.4    16.4    1.39
2.6.0-test4-mm4      4  129     59.7    43.1    16.9    1.61
io_other:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          2  116     67.2    48.0    21.4    1.45
2.6.0-test4-mm2      2  110     70.0    41.0    18.8    1.39
2.6.0-test4-mm4      2  111     69.4    40.8    18.8    1.39
read_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          2  109     72.5    8.6     5.5     1.36
2.6.0-test4-mm2      2  106     73.6    8.3     5.6     1.34
2.6.0-test4-mm4      2  100     78.0    6.5     5.0     1.25
list_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          2  97      79.4    0.0     8.2     1.21
2.6.0-test4-mm2      2  96      80.2    0.0     7.3     1.22
2.6.0-test4-mm4      2  95      80.0    0.0     7.4     1.19
mem_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          2  101     78.2    67.0    3.0     1.26
2.6.0-test4-mm2      2  98      79.6    66.5    3.1     1.24
2.6.0-test4-mm4      2  93      84.9    65.0    3.2     1.16
dbench_load:
Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
2.6.0-test4          4  390     19.5    6.2     57.3    4.88
2.6.0-test4-mm2      3  242     31.8    3.0     44.2    3.06
2.6.0-test4-mm4      4  260     29.6    3.2     45.0    3.25

Some i/o effects and some memory balance effects.

Con

