Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268538AbTBOGlw>; Sat, 15 Feb 2003 01:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268541AbTBOGlw>; Sat, 15 Feb 2003 01:41:52 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:5094 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S268538AbTBOGlv>;
	Sat, 15 Feb 2003 01:41:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] cfq3a i/o scheduler with contest
Date: Sat, 15 Feb 2003 17:51:43 +1100
User-Agent: KMail/1.5
Cc: Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302151751.43433.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

why not do a set of these too?

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   79      94.9    0.0     0.0     1.00
2.5.60-cfq          1   79      94.9    0.0     0.0     1.00
2.5.60-cfq3a        1   80      93.8    0.0     0.0     1.00
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   99      78.8    1.0     4.0     1.25
2.5.60-cfq          1   101     78.2    1.0     4.0     1.28
2.5.60-cfq3a        2   98      80.6    1.0     4.0     1.23
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   101     76.2    1.0     5.0     1.28
2.5.60-cfq          1   115     66.1    1.0     4.3     1.46
2.5.60-cfq3a        2   106     71.7    1.0     3.8     1.32
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   139     54.7    29.0    12.1    1.76
2.5.60-cfq          1   606     12.7    212.0   21.6    7.67
2.5.60-cfq3a        2   134     56.0    23.6    9.6     1.68
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   90      83.3    10.8    5.5     1.14
2.5.60-cfq          1   89      84.3    10.8    5.6     1.13
2.5.60-cfq3a        2   89      84.3    10.8    5.6     1.11
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   103     74.8    6.2     6.8     1.30
2.5.60-cfq          1   103     76.7    6.9     5.8     1.30
2.5.60-cfq3a        2   103     75.7    6.8     5.8     1.29
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   95      80.0    0.0     6.3     1.20
2.5.60-cfq          1   95      81.1    0.0     6.3     1.20
2.5.60-cfq3a        2   96      80.2    0.0     6.2     1.20

Con
