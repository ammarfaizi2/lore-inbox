Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSIDV5N>; Wed, 4 Sep 2002 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSIDV5N>; Wed, 4 Sep 2002 17:57:13 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:28326 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S315419AbSIDV5L>; Wed, 4 Sep 2002 17:57:11 -0400
Message-ID: <20020904220055.21349.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 05 Sep 2002 06:00:55 +0800
Subject: BYTE Unix Benchmarks Version 3.6
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've just ran the BYTE Unix Benchmarks Version 3.6 on the 2.4.19 and on the 2.5.33 kernel.
Here it goes the results:

BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux localhost.localdomain 2.4.19 #10 Fri Aug 23 20:53:06 BST 2002 i686 unknown
  Start Benchmark Run: Wed Sep  4 22:11:32 BST 2002
   1 interactive users.
Dhrystone 2 without register variables   1499020.6 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     1501168.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         3598100.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        201521.0 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           190245.9 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             201904.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            201906.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           210562.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          210385.9 lps   (10 secs, 6 samples)
System Call Overhead Test                407402.6 lps   (10 secs, 6 samples)
Pipe Throughput Test                     476268.6 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test        218969.9 lps   (10 secs, 6 samples)
Process Creation Test                      9078.6 lps   (10 secs, 6 samples)
Execl Throughput Test                       998.0 lps   (9 secs, 6 samples)
File Read  (10 seconds)                  1571652.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  109237.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   24329.0 KBps  (10 secs, 6 samples)
File Read  (30 seconds)                  1562505.0 KBps  (30 secs, 6 samples)
File Write (30 seconds)                  113152.0 KBps  (30 secs, 6 samples)
File Copy  (30 seconds)                   14334.0 KBps  (30 secs, 6 samples)
C Compiler Test                             470.9 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)                980.4 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)                544.1 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                287.0 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                147.0 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          42311.6 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            18915.4 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   210385.9       82.8
Dhrystone 2 without register variables       22366.3  1499020.6       67.0
Execl Throughput Test                           16.5      998.0       60.5
File Copy  (30 seconds)                        179.0    14334.0       80.1
Pipe-based Context Switching Test             1318.5   218969.9      166.1
Shell scripts (8 concurrent)                     4.0      147.0       36.8
                                                                 =========
     SUM of  6 items                                                 493.2
     AVERAGE                                                          82.2



sh pgms/report.sh results/log > results/report
sh pgms/index.sh pgms/index.base results/log >> results/report
cat results/report

  BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux localhost.localdomain 2.5.33 #32 Tue Sep 3 22:18:19 BST 2002 i686 unknown
  Start Benchmark Run: Wed Sep  4 20:46:31 BST 2002
   1 interactive users.
Dhrystone 2 without register variables   1488327.9 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     1488265.3 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         3435944.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        197870.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           145140.8 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             104440.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            177757.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           208476.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          208443.3 lps   (10 secs, 6 samples)
System Call Overhead Test                397276.7 lps   (10 secs, 6 samples)
Pipe Throughput Test                     434561.9 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test        148653.5 lps   (10 secs, 6 samples)
Process Creation Test                      5422.1 lps   (10 secs, 6 samples)
Execl Throughput Test                       771.6 lps   (10 secs, 6 samples)
File Read  (10 seconds)                  1553289.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  132002.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   17994.0 KBps  (10 secs, 6 samples)
File Read  (30 seconds)                  1540682.0 KBps  (30 secs, 6 samples)
File Write (30 seconds)                  137781.0 KBps  (30 secs, 6 samples)
File Copy  (30 seconds)                   11460.0 KBps  (30 secs, 6 samples)
C Compiler Test                             450.9 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)                876.7 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)                480.3 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                251.0 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                126.0 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          33530.4 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            18514.3 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   208443.3       82.0
Dhrystone 2 without register variables       22366.3  1488327.9       66.5
Execl Throughput Test                           16.5      771.6       46.8
File Copy  (30 seconds)                        179.0    11460.0       64.0
Pipe-based Context Switching Test             1318.5   148653.5      112.7
Shell scripts (8 concurrent)                     4.0      126.0       31.5
                                                                 =========
     SUM of  6 items                                                 403.6
     AVERAGE                                                          67.3

Comments?

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
