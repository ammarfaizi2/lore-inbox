Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269911AbRHJFCp>; Fri, 10 Aug 2001 01:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269907AbRHJFCg>; Fri, 10 Aug 2001 01:02:36 -0400
Received: from mail.mesatop.com ([208.164.122.9]:6405 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S269911AbRHJFCW>;
	Fri, 10 Aug 2001 01:02:22 -0400
Message-Id: <200108100502.f7A52Ve23324@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Some dbench 32 results for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7
Date: Thu, 9 Aug 2001 23:00:22 -0600
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran dbench 32 for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7.
Each set of three runs were performed right after a boot,
running vmstat, and time ./dbench 32 with no pauses in
between.  The hardware is 384 MB, 450 P3, UP, IDE disk with
ReiserFS on all partitions. The tests were done from a
transparent Konsole and KDE2.

After this summary, the more verbose results are provided.

Steven

Run #1 Throughput 5.88569 MB/sec   2.4.8-pre8
Run #2 Throughput 5.95613 MB/sec   2.4.8-pre8
Run #3 Throughput 5.8547 MB/sec    2.4.8-pre8

Run #4 Throughput 7.84171 MB/sec   2.4.7-ac10
Run #5 Throughput 7.68447 MB/sec   2.4.7-ac10
Run #6 Throughput 7.85119 MB/sec   2.4.7-ac10

Run #7 Throughput 10.2184 MB/sec   2.4.7
Run #8 Throughput 10.0105 MB/sec   2.4.7
Run #9 Throughput 10.0215 MB/sec   2.4.7

-------------------------------------------------------------------------------
2.4.8-pre8

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0      0 267028   4180  61008   0   0   176    52  572   209  10   8  82

32 clients started
[....snipped]
Throughput 5.88569 MB/sec (NB=7.35711 MB/sec  58.8569 MBit/sec)
37.16user 398.40system 11:57.77elapsed 60%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 281788   6780  38076   0   0   131  1873 4114   235   7  59  34

32 clients started
[....snipped]
Throughput 5.95613 MB/sec (NB=7.44517 MB/sec  59.5613 MBit/sec)
36.27user 393.72system 11:50.20elapsed 60%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0      0 282196   6880  38088   0   0   121  2227 4799   239   7  68  25

32 clients started
[....snipped]
Throughput 5.8547 MB/sec (NB=7.31837 MB/sec  58.547 MBit/sec)
36.53user 397.94system 12:02.49elapsed 60%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 281508   7624  38092   0   0   115  2377 5087   241   7  72  21


-------------------------------------------------------------------------------
2.4.7-ac10

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  1      0 266976   4160  60952   0   0   461   115 1284   428  25  21  54

32 clients started
[....snipped]
Throughput 7.84171 MB/sec (NB=9.80214 MB/sec  78.4171 MBit/sec)
36.41user 289.55system 8:59.79elapsed 60%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 295104   4472  24608   0   0   199  2014 4534   327  11  67  22

32 clients started
[....snipped]
Throughput 7.68447 MB/sec (NB=9.60559 MB/sec  76.8447 MBit/sec)
36.21user 287.81system 9:10.72elapsed 58%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 296612   4768  23716   0   0   169  2242 4926   320   9  73  18

32 clients started
[....snipped]
Throughput 7.85119 MB/sec (NB=9.81399 MB/sec  78.5119 MBit/sec)
36.55user 272.83system 8:59.02elapsed 57%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0      0 296796   4648  23720   0   0   158  2317 5055   318   9  75  17

-------------------------------------------------------------------------------
2.4.7

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 250760  20028  60940   0   0   601   109 1550   448  25  24  51

32 clients started
[....snipped]
Throughput 10.2184 MB/sec (NB=12.773 MB/sec  102.184 MBit/sec)
35.41user 286.38system 6:53.41elapsed 77%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 299012   4208  24496   0   0   278  1964 4591   242  13  72  15

32 clients started
[....snipped]
Throughput 10.0105 MB/sec (NB=12.5131 MB/sec  100.105 MBit/sec)
36.53user 283.74system 7:02.99elapsed 75%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0 299364   4800  23628   0   0   231  2222 5010   218  11  78  10

32 clients started
[....snipped]
Throughput 10.0215 MB/sec (NB=12.5269 MB/sec  100.215 MBit/sec)
35.69user 287.32system 7:02.51elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
[....snipped]
0inputs+0outputs (1011major+1435minor)pagefaults 0swaps
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0      0 299236   4796  23748   0   0   213  2321 5171   207  11  81   9

