Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278083AbRJRWww>; Thu, 18 Oct 2001 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278185AbRJRWwm>; Thu, 18 Oct 2001 18:52:42 -0400
Received: from dns1.geolatina.com ([209.92.187.33]:41742 "EHLO
	core.arrancar.com") by vger.kernel.org with ESMTP
	id <S278083AbRJRWwf>; Thu, 18 Oct 2001 18:52:35 -0400
Date: Tue, 16 Oct 2001 13:53:22 -0300
From: martin sepulveda <martin@joydivision.com.ar>
To: linux-kernel@vger.kernel.org
Subject: load 1 at idle, 2.4.12-ac3
Message-Id: <20011016135322.02ed0f97.martin@joydivision.com.ar>
X-Mailer: Sylpheed version 0.6.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

while using 2.4.12-ac3 (plus rik's 2.4.12-ac3-vmpatch), y get a load of about 1, while
doing the same on a 2.4.10 gave about 0.10 - 0.15 load

root@core:~# uptime
  1:47pm  up  5:36,  4 users,  load average: 1.11, 1.02, 1.04
root@core:~# 

while a top doesn't show nothing to happen:

  1:48pm  up  5:36,  4 users,  load average: 1.05, 1.01, 1.03
89 processes: 81 sleeping, 8 running, 0 zombie, 0 stopped
CPU states:  2.7% user,  1.7% system,  0.0% nice, 95.4% idle
Mem:   126992K av,  100044K used,   26948K free,     196K shrd,    2588K buff
Swap:  265032K av,   17788K used,  247244K free                   62348K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 2721 root      15  -1 23668  10M  1468 R <   2.5  8.6   6:51 X
11778 root      10   0  1068 1068   820 R     0.3  0.8   0:00 top
    1 root       8   0    80   68    68 S     0.0  0.0   0:03 init
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    5 root       9   0     0    0     0 SW    0.0  0.0   0:01 kswapd

slackware 8.0, X 4.1.0, fvwm 1.24r, xfstt, esd, apache, mysql (both without
any connection but running).
P III 550, 128 MB, IDE HD (1), epic100 module for eth0, advansys module
for a CDR.

any idea?

M.

-- 
Talent does what it can, genius what it must.
I do what I get paid to do.
