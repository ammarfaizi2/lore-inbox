Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284617AbRLMSkK>; Thu, 13 Dec 2001 13:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284569AbRLMSkB>; Thu, 13 Dec 2001 13:40:01 -0500
Received: from mustard.heime.net ([194.234.65.222]:49375 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284753AbRLMSjt>; Thu, 13 Dec 2001 13:39:49 -0500
Date: Thu, 13 Dec 2001 19:39:25 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: [BUG] RAID sub system
In-Reply-To: <Pine.LNX.4.33.0112131320350.15231-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112131937310.27346-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> do did you actually try this with a bunch of parallel dd's?

I just did now. Same result:

# vmstat 2
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 200  1   1676   3200   3012 786004   0 292 42034   298  791   745   4  29  67
 0 200  1   1676   3308   3136 785760   0   0 44304     0  748   758   3  15  82
 0 200  1   1676   3296   3232 785676   0   0 44236     0  756   710   2  23  75
 0 200  1   1676   3304   3356 785548   0   0 38662    70  778   791   3  19  78
 0 200  1   1676   3200   3456 785552   0   0 33536     0  693   594   3  13  84
 1 200  0   1676   3224   3528 785192   0   0 35330    24  794   712   3  16  81
 0 200  0   1676   3304   3736 784324   0   0 30524    74  725   793  12  14  74
 0 200  0   1676   3256   3796 783664   0   0 29984     0  718   826   4  10  86
 0 200  0   1676   3288   3868 783592   0   0 25540   152  763   812   3  17  80
 0 200  0   1676   3276   3908 783472   0   0 22820     0  693   731   0   7  92
 0 200  0   1676   3200   3964 783540   0   0 23312     6  759   827   4  11  85
 0 200  0   1676   3308   3984 783452   0   0 17506     0  687   697   0  11  89
 0 200  0   1676   3388   4012 783888   0   0 14512     0  671   638   1   5  93
 0 200  0   2188   3208   4048 784156   0 512 16104   548  707   833   2  10  88
 0 200  0   3468   3204   4048 784788   0  66  8220    66  628   662   0   3  96
 0 200  0   3468   3296   4060 784680   0   0  1036     6  687   714   1   6  93
 0 200  0   3468   3316   4060 784668   0   0  1018     0  613   631   1   2  97
 0 200  0   3468   3292   4060 784688   0   0  1034     0  617   638   0   3  97
 0 200  0   3468   3200   4068 784772   0   0  1066     6  694   727   2   4  94

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


