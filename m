Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290904AbSASCg4>; Fri, 18 Jan 2002 21:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290905AbSASCgq>; Fri, 18 Jan 2002 21:36:46 -0500
Received: from insws8502.gs.com ([204.4.182.11]:14248 "HELO insws8502.gs.com")
	by vger.kernel.org with SMTP id <S290904AbSASCgf>;
	Fri, 18 Jan 2002 21:36:35 -0500
Message-Id: <FBC7494738B7D411BD7F00902798761908BFF31F@gsny49e.ny.fw.gs.com>
From: "Ahmed, Zameer" <Zameer.Ahmed@gs.com>
To: linux-kernel@vger.kernel.org
Cc: "'zameer.ahmed@gs.com'" <Zameer.Ahmed@gs.com>
Subject: High uptime but unpredicatble behaviour (machine slowing), any way to fix without rebooting?
Date: Fri, 18 Jan 2002 21:36:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
	I am running machine having 2.2.12 kernel and its been running under
moderate loads for 313 days. But now I find the kernel behaving errtically
including dumping core while running top and recovering sometimes. Any idea
why the machine has such a high system load? I would want to make this
machine run more longer time than to reboot. It would be a shame to reboot
the machine. 

Any suggestions most welcome.

Thanks
Zameer A.


% uname -a
Linux cow.jany.gs.com 2.2.12 #7 SMP Tue Dec 7 16:43:39 EST 1999 i686 unknown

  9:33pm  up 313 days,  6:33,  1 user,  load average: 0.00, 0.10, 0.08
67 processes: 66 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
CPU1 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
Mem:   971864K av,  848148K used,  123716K free,   65196K shrd,  341820K
buff
Swap: 1542200K av,    5172K used, 1537028K free                   31960K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE LC STAT %CPU %MEM   TIME COMMAND
22009 ahmedz    11   0   896  896   684  0 R     6.4  0.0   0:00 top
11085 procmon    1   0 89980  87M 12008  1 S     2.1  9.2   1:48 secexpr
    1 root       0   0   164  116    92  1 S     0.0  0.0   0:05 init
    2 root       0   0     0    0     0  1 SW    0.0  0.0   0:09 kflushd
    3 root       0   0     0    0     0  0 SW    0.0  0.0  24:54 kupdate
    4 root       0   0     0    0     0  1 SW    0.0  0.0   0:00 kpiod
    5 root       0   0     0    0     0  1 SW    0.0  0.0  12:59 kswapd
  391 bin        0   0   136   92    76  0 S     0.0  0.0   0:01 portmap
  437 root       0   0   396  384   296  1 S     0.0  0.0   3:19 syslogd
  447 root       0   0   448  168   136  0 S     0.0  0.0   0:03 klogd
  461 daemon     0   0   140  104    76  0 S     0.0  0.0   0:01 atd
  474 root       0   0   152  108    80  1 S     0.0  0.0   1:23 crond
  487 root       0   0   148   96    36  1 S     0.0  0.0   0:03 inetd
  500 root       0   0  1052  480   356  1 S     0.0  0.0  17:54 named
  513 root       0   0   292  268   168  1 S     0.0  0.0  94:27 routed
  528 root       0   0  1356 1356  1164  0 S     0.0  0.1  50:55 xntpd
