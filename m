Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSI2RPF>; Sun, 29 Sep 2002 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSI2RPF>; Sun, 29 Sep 2002 13:15:05 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:20118 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261509AbSI2ROm>; Sun, 29 Sep 2002 13:14:42 -0400
Message-ID: <20020929171409.10733.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 30 Sep 2002 01:14:09 +0800
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <conman@kolivas.net>
[...]
> > > ProcessLoad, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2
> > Why ? 
> > If look at the numbers I assume that 2.5.39 is faster then 2.4.19.
> > Am I missing something?
> 
> Sorry, typo should read 2.5.39 is faster than 2.4.19 and same as 2.5.38-mm2
Ok.
 
> > I'll run further test...
> 
> Not really needed. I'm convinced the difference is there, and the people who can
> act on the data probably will be happy with that much information too. Some are
> less satisfied with the quality of the data unless there is firm statistical
> data to support the hypothesis. Your time is better spent on other things.

I've just ran further tests...
Administrator@OIVT444P ~
$ cat /cygdrive/log/results.log

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  133.07          98%             1.00
2.4.19                  133.16          98%             1.00
2.4.19                  135.43          97%             1.02
2.5.38-mm2              138.19          97%             1.04
2.5.38-mm2              138.47          96%             1.04
2.5.38-mm2              138.72          97%             1.04
2.5.38-mm2              139.54          96%             1.05
2.5.38-mm2              139.59          96%             1.05
2.5.38-mm2              139.88          96%             1.05
2.5.39                  138.30          96%             1.04
2.5.39                  138.63          96%             1.04
2.5.39                  138.70          96%             1.04
2.5.39                  138.70          96%             1.04
2.5.39                  139.44          96%             1.05
2.5.39                  139.99          96%             1.05

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  200.43          60%             1.51
2.4.19                  203.11          60%             1.53
2.4.19                  203.97          59%             1.53
2.5.38-mm2              190.13          70%             1.43
2.5.38-mm2              194.06          69%             1.46
2.5.38-mm2              194.25          69%             1.46
2.5.38-mm2              194.42          69%             1.46
2.5.38-mm2              195.19          69%             1.47
2.5.38-mm2              207.36          64%             1.56
2.5.39                  188.72          71%             1.42
2.5.39                  190.44          70%             1.43
2.5.39                  191.37          70%             1.44
2.5.39                  191.48          70%             1.44
2.5.39                  193.60          69%             1.45
2.5.39                  199.50          67%             1.50

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  486.58          27%             3.66
2.4.19                  593.72          22%             4.46
2.4.19                  637.61          21%             4.79
2.5.38-mm2              232.35          61%             1.75
2.5.38-mm2              237.83          57%             1.79
2.5.38-mm2              247.05          58%             1.86
2.5.38-mm2              274.39          50%             2.06
2.5.38-mm2              281.40          49%             2.11
2.5.38-mm2              295.87          47%             2.22
2.5.39                  233.58          59%             1.76
2.5.39                  242.98          57%             1.83
2.5.39                  272.38          51%             2.05
2.5.39                  294.52          50%             2.21
2.5.39                  304.73          45%             2.29
2.5.39                  328.01          42%             2.46

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  172.24          78%             1.29
2.4.19                  174.74          77%             1.31
2.4.19                  174.87          77%             1.31
2.5.38-mm2              165.53          82%             1.24
2.5.38-mm2              170.00          80%             1.28
2.5.38-mm2              170.89          79%             1.28
2.5.38-mm2              171.84          79%             1.29
2.5.38-mm2              171.96          79%             1.29
2.5.38-mm2              172.15          79%             1.29
2.5.39                  167.92          81%             1.26
2.5.39                  168.38          81%             1.27
2.5.39                  170.16          80%             1.28
2.5.39                  170.64          80%             1.28
2.5.39                  170.80          80%             1.28
2.5.39                  172.68          79%             1.30

Con, do you think is a good idea add the capability to the contest bechmark to provide an analisys of the results ? I have a few ideas, if you want we can contunue the discussion in pvt.

Ciao,
            Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
