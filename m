Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262398AbSI2Fy1>; Sun, 29 Sep 2002 01:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbSI2Fy1>; Sun, 29 Sep 2002 01:54:27 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:11981 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262398AbSI2Fy0>;
	Sun, 29 Sep 2002 01:54:26 -0400
Message-ID: <1033279186.3d9696d22910b@kolivas.net>
Date: Sun, 29 Sep 2002 15:59:46 +1000
From: Con Kolivas <conman@kolivas.net>
To: =?ISO-8859-1?B?RGlldGVyIE78dHplbA==?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Preempt effect on 2.5.39 with contest 0.41
References: <200209290709.47843.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200209290709.47843.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dieter Nützel <Dieter.Nuetzel@hamburg.de>:

> Con,
> 
> can we please have 2.4.19-ck-pe furthermore for comparison, please?

Ok here's the full set as I have it (note ck7 is preempt and low latency ON; I
don't have results with it off):

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  67.71           98%             1.00
2.4.19-ck7              69.62           94%             1.03
2.5.38                  72.38           94%             1.07
2.5.38-mm3              73.00           93%             1.08
2.5.39                  73.17           93%             1.08
2.5.39-pe               73.03           94%             1.08

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  110.75          57%             1.64
2.4.19-ck7              89.93           73%             1.33
2.5.38                  85.71           79%             1.27
2.5.38-mm3              96.32           72%             1.42
2.5.39                  91.0            76%             1.31
2.5.39-pe               83.6            82%             1.23

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  216.05          33%             3.19
2.4.19-ck7              118.69          57%             1.75
2.5.38                  887.76          8%              13.11
2.5.38-mm3              105.17          70%             1.55
2.5.39                  226             37%             3.20
2.5.39-pe               234             34%             3.43

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  105.40          70%             1.56
2.4.19-ck7              92.54           80%             1.37
2.5.38                  107.89          73%             1.59
2.5.38-mm3              117.09          63%             1.73
2.5.39                  103.72          72%             1.53
2.5.39-pe               103.95          73%             1.54

Con.
