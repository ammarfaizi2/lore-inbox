Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSI1PSj>; Sat, 28 Sep 2002 11:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261869AbSI1PSj>; Sat, 28 Sep 2002 11:18:39 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:47596 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261868AbSI1PSd>; Sat, 28 Sep 2002 11:18:33 -0400
Message-ID: <20020928151726.18496.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: conman@kolivas.net
Date: Sat, 28 Sep 2002 23:17:26 +0800
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP Omnibook 6000 (laptop), 256 MiB of RAM, PIII@800.
Test against 2.4.19, 2.5.38-mm2, 2.5.39

What I did:
$ rebootin "kernel" apm=off single
$ contest -n 3

Results:
Administrator@OIVT444P /cygdrive/log
$ cat results.log

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  133.07          98%             1.00
2.4.19                  133.16          98%             1.00
2.4.19                  135.43          97%             1.02
2.5.38-mm2              138.19          97%             1.04
2.5.38-mm2              138.47          96%             1.04
2.5.38-mm2              139.54          96%             1.05
2.5.39                  138.30          96%             1.04
2.5.39                  138.63          96%             1.04
2.5.39                  139.99          96%             1.05

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  200.43          60%             1.51
2.4.19                  203.11          60%             1.53
2.4.19                  203.97          59%             1.53
2.5.38-mm2              194.42          69%             1.46
2.5.38-mm2              195.19          69%             1.47
2.5.38-mm2              207.36          64%             1.56
2.5.39                  190.44          70%             1.43
2.5.39                  191.37          70%             1.44
2.5.39                  193.60          69%             1.45

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  486.58          27%             3.66
2.4.19                  593.72          22%             4.46
2.4.19                  637.61          21%             4.79
2.5.38-mm2              232.35          61%             1.75
2.5.38-mm2              237.83          57%             1.79
2.5.38-mm2              274.39          50%             2.06
2.5.39                  242.98          57%             1.83
2.5.39                  294.52          50%             2.21
2.5.39                  328.01          42%             2.46

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  172.24          78%             1.29
2.4.19                  174.74          77%             1.31
2.4.19                  174.87          77%             1.31
2.5.38-mm2              165.53          82%             1.24
2.5.38-mm2              170.00          80%             1.28
2.5.38-mm2              171.96          79%             1.29
2.5.39                  167.92          81%             1.26
2.5.39                  170.80          80%             1.28
2.5.39                  172.68          79%             1.30

Ciao,
          Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
