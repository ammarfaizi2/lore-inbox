Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbTAUUdY>; Tue, 21 Jan 2003 15:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbTAUUdY>; Tue, 21 Jan 2003 15:33:24 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:46860 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267215AbTAUUdX>; Tue, 21 Jan 2003 15:33:23 -0500
Date: Tue, 21 Jan 2003 15:41:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ctxbench 2.4.20 vs. 2.5.5[789]
Message-ID: <Pine.LNX.4.44.0301211538530.1272-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general the IPC continues to trend slower.




================================================================
    Run information
================================================================

Run: ALL
  CPU_MHz              348.492
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.4.20
  Ncpu                 1

================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average    avg/MHz
  2.4.20.out              47304      47514      47424    136.083
  2.5.57.out              40728      40777      40745    116.944
  2.5.58.out              37114      37157      37129    106.562
  2.5.59.out              39992      40127      40053    114.959

                                   loops/sec
message queue               low       high    average    avg/MHz
  2.4.20.out              75206      83700      80822    231.920
  2.5.57.out              77646      77912      77809    223.320
  2.5.58.out              75526      77816      76481    219.504
  2.5.59.out              72676      73391      73059    209.689

                                   loops/sec
pipes                       low       high    average    avg/MHz
  2.4.20.out              87640      88381      87889    252.198
  2.5.57.out              65323      74089      70839    203.315
  2.5.58.out              70613      72484      71370    204.837
  2.5.59.out              65904      73331      70731    203.006

                                   loops/sec
semiphore                   low       high    average    avg/MHz
  2.4.20.out              92052      92569      92307    264.876
  2.5.57.out              80238      81108      80777    231.838
  2.5.58.out              81754      83169      82280    236.148
  2.5.59.out              78079      78199      78140    224.271

                                   loops/sec
spin+yield                  low       high    average    avg/MHz
  2.4.20.out             211801     211957     211855    607.921
  2.5.57.out             179346     179889     179579    515.410
  2.5.58.out             178850     179044     178941    513.568
  2.5.59.out             174010     174036     174023    499.466

                                   loops/sec
spinlock                    low       high    average    avg/MHz
  2.4.20.out                  4          4          4      0.014
  2.5.57.out                  3          3          3      0.009
  2.5.58.out                  3          3          3      0.009
  2.5.59.out                  3          3          3      0.009

-- 
bill davidsen

