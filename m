Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTAUWjj>; Tue, 21 Jan 2003 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTAUWjj>; Tue, 21 Jan 2003 17:39:39 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:62983 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267255AbTAUWjg>; Tue, 21 Jan 2003 17:39:36 -0500
Date: Tue, 21 Jan 2003 17:48:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK ctxbench 2.5.59 preempt, no preempt, ingo sched
Message-ID: <Pine.LNX.4.44.0301211744450.1288-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The interesting thing about this is that with the Ingo scheduler the 
semiphone IPC test hung solid.

All test uni kernel, 59n = nopreempt, 59p = preempt, 59ni = no preempt 
Ingo scheduler patch. Response testing will follow, it take a l-o-n-g time 
to run.




================================================================
    Run information
================================================================

Run: ALL
  CPU_MHz              348.395
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           2.5.59-1n
  Ncpu                 1

================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average    avg/MHz
  2.5.59n.out             41310      41865      41542    119.239
  2.5.59ni.out            40032      40096      40054    114.946
  2.5.59p.out             39992      40127      40053    114.959

                                   loops/sec
message queue               low       high    average    avg/MHz
  2.5.59n.out             76381      76537      76472    219.500
  2.5.59ni.out            71558      73266      72299    207.483
  2.5.59p.out             72676      73391      73059    209.689

                                   loops/sec
pipes                       low       high    average    avg/MHz
  2.5.59n.out             67564      68632      67952    195.044
  2.5.59ni.out            68234      68307      68258    195.888
  2.5.59p.out             65904      73331      70731    203.006

                                   loops/sec
semiphore                   low       high    average    avg/MHz
  2.5.59n.out             83412      83720      83536    239.774
  2.5.59ni.out            81495      81572      81535    233.989
  2.5.59p.out             78079      78199      78140    224.271

                                   loops/sec
spin+yield                  low       high    average    avg/MHz
  2.5.59n.out            181186     181848     181446    520.806
  2.5.59ni.out           158614     176824     170709    489.899
  2.5.59p.out            174010     174036     174023    499.466

                                   loops/sec
spinlock                    low       high    average    avg/MHz
  2.5.59n.out                 3          3          3      0.009
  2.5.59ni.out                4          5          4      0.014
  2.5.59p.out                 3          3          3      0.009

-- 
bill davidsen

