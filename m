Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319567AbSIMJEl>; Fri, 13 Sep 2002 05:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319568AbSIMJEl>; Fri, 13 Sep 2002 05:04:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54289 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S319567AbSIMJEi>; Fri, 13 Sep 2002 05:04:38 -0400
Message-Id: <200209130904.g8D94Zp09604@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Strange "Swap:" value in top
Date: Fri, 13 Sep 2002 11:59:41 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my test server. My biggest uptime ever.

All is running fine, kudos to all kernel developers!

There is one cosmetic thing:

11:53am  up 106 days, 23:31,  1 user,  load average: 0.23, 0.05, 0.02
53 processes: 52 sleeping, 1 running, 0 zombie, 0 stopped
0.5% user,  3.9% system,  0.0% nice, 95.4% idle
Mem:    29612K av,   28384K used,    1228K free,       0K shrd,   18060K buff
Swap:   98296K av,    4312K used,   93984K free                 4294964540K cached
                                                                ^^^^^^^^^^^^^^^^^^
# cat meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  30322688 28688384  1634304        0 18485248 18446744073708027904
Swap: 100655104  4415488 96239616                  ^^^^^^^^^^^^^^^^^^^^
MemTotal:        29612 kB
MemFree:          1596 kB
MemShared:           0 kB
Buffers:         18052 kB
Cached:       4294964444 kB  <-------------
SwapCached:       1364 kB
Active:           5820 kB
Inactive:        12016 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        29612 kB
LowFree:          1596 kB
SwapTotal:       98296 kB
SwapFree:        93984 kB

# uname -a
Linux pegasus 2.4.18-pre6mhv_ll #2 SMP Wed Mar 27 11:17:36 GMT+2 2002 i686 unknown
--
vda
