Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbSIWHTJ>; Mon, 23 Sep 2002 03:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSIWHTJ>; Mon, 23 Sep 2002 03:19:09 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:20616 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S264918AbSIWHTI>;
	Mon, 23 Sep 2002 03:19:08 -0400
Message-ID: <1032765854.3d8ec19e18afb@kolivas.net>
Date: Mon, 23 Sep 2002 17:24:14 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de, Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.38-mm2 contest results
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here follow the contest benchmarks for 2.5.38-mm2

NoLoad:
Kernel                  Time            CPU
2.4.19                  66.56           99%
2.5.38                  68.25           99%
2.5.38-mm1              67.17           99%
2.5.38-mm2              67.48           99%

Process Load:
Kernel                  Time            CPU
2.4.19                  81.29           80%
2.5.38                  71.60           95%
2.5.38-mm1              70.49           95%
2.5.38-mm2              70.82           95%

IO Half Load:
Kernel                  Time            CPU
2.4.19                  101.39          69%
2.5.38                  81.26           90%
2.5.38-mm1              82.52           87%
2.5.38-mm2              78.46           91%

IO Full Load:
Kernel                  Time            CPU
2.4.19                  170.70          41%
2.5.38                  170.21          42%
2.5.38-mm1              434.41          16%
2.5.38-mm2              108.15          66%

Mem Load:
Kernel                  Time            CPU
2.4.19                  93.33           77%
2.5.38                  104.22          70%
2.5.38-mm1              92.97           77%
2.5.38-mm2              90.89           80%

As akpm has said, mm2 should fix the write starves read problem in mm2 and this
is clearly shown in the IO full load results being substantially better.
This is on an IDE system. 

Other results removed for clarity. All tests are done with gcc2.95.3 :\

Con.
