Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbSI0TiT>; Fri, 27 Sep 2002 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbSI0TiS>; Fri, 27 Sep 2002 15:38:18 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:13451 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262586AbSI0Thg>; Fri, 27 Sep 2002 15:37:36 -0400
Message-ID: <20020927193815.7164.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: conman@kolivas.net
Date: Sat, 28 Sep 2002 03:38:15 +0800
Subject: [Benchmark] Contest 0.37 2.5.28-mm2-preemptionON vs
    2.5.28-mm2-preemptionOFF
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here goes the results of contest0.37 against:
2.4.19                  
2.4.19-0.24pre4
2.4.19-ck7              
2.5.32-mm2-Nopre  
2.5.38-mm2

The goal of this test is compare preemption ON against preemption OFF

-mm2 io_load was repeated 6 times, then I added the average.
Pay attention that the results are passed through
sort.

Comments, suggestion are more then welcome.

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  130.39          100%            1.00
2.4.19-0.24pre4         130.53          100%            1.00
2.4.19-0.24pre4         130.64          99%             1.00
2.4.19-ck7              129.76          99%             1.00
2.5.32-mm2-Nopre        133.29          100%            1.02
2.5.38-mm2              134.45          100%            1.03

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  156.95          81%             1.20
2.4.19-0.24pre4         156.99          81%             1.20
2.4.19-0.24pre4         157.42          81%             1.21
2.4.19-ck7              147.41          87%             1.13
2.5.32-mm2-Nopre        150.13          88%             1.15
2.5.38-mm2              151.41          88%             1.16

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  376.46          35%             2.89
2.4.19-0.24pre4         203.49          66%             1.56
2.4.19-0.24pre4         218.82          62%             1.68
2.4.19-ck7              785.55          16%             6.02
2.5.32-mm2-Nopre        176.52          77%             1.35
2.5.32-mm2-Nopre        181.21          75%             1.39
2.5.32-mm2-Nopre        189.31          72%             1.45
2.5.32-mm2-Nopre        198.59          70%             1.52
2.5.32-mm2-Nopre        198.96          68%             1.53
2.5.32-mm2-Nopre        204.19          67%             1.57
	average:	191.46

2.5.38-mm2              190.04          72%             1.46
2.5.38-mm2              195.49          70%             1.50
2.5.38-mm2              199.44          69%             1.53
2.5.38-mm2              200.14          69%             1.53
2.5.38-mm2              221.99          61%             1.70
2.5.38-mm2              263.03          52%             2.02
	average:	211.68
mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  170.79          78%             1.31
2.4.19-0.24pre4         197.17          76%             1.51
2.4.19-0.24pre4         212.25          74%             1.63
2.4.19-ck7              175.24          75%             1.34
2.5.32-mm2-Nopre        161.05          84%             1.24
2.5.38-mm2              169.33          80%             1.30

Ciao,
             Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
