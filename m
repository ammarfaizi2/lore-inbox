Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264183AbSIVMnY>; Sun, 22 Sep 2002 08:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264196AbSIVMnX>; Sun, 22 Sep 2002 08:43:23 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:36482 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S264183AbSIVMnW>;
	Sun, 22 Sep 2002 08:43:22 -0400
Message-ID: <1032698909.3d8dbc1dc8ea3@kolivas.net>
Date: Sun, 22 Sep 2002 22:48:29 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.38{-mm1} contest results
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are the latest contest results including 2.5.38 and 2.5.38-mm1

NoLoad:
Kernel                  Time            CPU
2.4.19                  66.56           99%
2.4.19-ck7              65.77           99%
2.4.19-ac4              66.31           99%
2.5.36                  67.45           99%
2.5.36-mm1              67.39           99%
2.5.37                  67.25           99%
2.5.38                  68.25           99%
2.5.38-mm1              67.17           99%

Process Load:
Kernel                  Time            CPU
2.4.19                  81.29           80%
2.4.19-ck7              70.14           93%
2.4.19-ac4              71.10           92%
2.5.36                  71.04           94%
2.5.36-mm1              70.68           95%
2.5.37                  70.51           95%
2.5.38                  71.60           95%
2.5.38-mm1              70.49           95%

IO Half Load:
Kernel                  Time            CPU
2.4.19                  101.39          69%
2.4.19-ck7              75.96           88%
2.4.19-ac4              97.56           73%
2.5.36                  79.30           91%
2.5.36-mm1              100.05          74%
2.5.37                  77.69           93%
2.5.38                  81.26           90%
2.5.38-mm1              82.52           87%

IO Full Load:
Kernel                  Time            CPU
2.4.19                  170.70          41%
2.4.19-ck7              90.95           74%
2.4.19-ac4              105.53          68%
2.5.36                  197.08          36%
2.5.36-mm1              220.14          33%
2.5.37                  209.75          33%
2.5.38                  170.21          42%
2.5.38-mm1              434.41          16%

Mem Load:
Kernel                  Time            CPU
2.4.19                  93.33           77%
2.4.19-ck7              123.15          57%
2.4.19-ac4              117.09          61%
2.5.36                  121.02          59%
2.5.36-mm1              100.47          73%
2.5.37                  104.75          70%
2.5.38                  104.22          70%
2.5.38-mm1              92.97           77%

As you can see, 2.5.38 is improving in most areas. 2.5.38-mm1 has excellent
performance under mem load now, but exhibits significant slow down under full IO
load. 

To reproduce full IO load, continuously copy /dev/zero in Ram sized chunks to
the same disk and conduct a kernel compile on that disk and time the kernel compile.

http://contest.kolivas.net

Comments?
Con.

