Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTK0X43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTK0X43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:56:29 -0500
Received: from [200.214.116.67] ([200.214.116.67]:36570 "HELO vialink.com.br")
	by vger.kernel.org with SMTP id S261719AbTK0X41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:56:27 -0500
Message-ID: <3FC68F40.7070403@vialink.com.br>
Date: Thu, 27 Nov 2003 21:56:48 -0200
From: Juan Carlos Castro y Castro <jcastro@vialink.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange priority for mdrecoveryd process
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me, I'm not on the list.

Has anyone seen anything like that? top gives me a weirdly huge number 
for the mdrecoveryd process priority. I use 2.4.23-rc3 on an athlon, 
with patches for i2c, lm_sensors, and netfilter patch-o-matic. My config 
file is like Red Hat 9's, except for the new options. I'll give it if 
necessary.

Thanks in advance,
Juan

 21:49:29  up  1:50,  4 users,  load average: 0,04, 0,10, 0,04
80 processes: 78 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   8,7% user   2,5% system   0,0% nice   0,0% iowait  88,6% idle
Mem:   248108k av,  241860k used,    6248k free,       0k shrd,   10980k 
buff
       123520k active,             102132k inactive
Swap:  257032k av,   11164k used,  245868k free                   85068k 
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 2515 root      15   0  299M  42M  4620 S     5,5 17,6   3:21   0 X
 2929 root      16   0 11644  10M  7420 R     1,9  4,3   0:07   0 
gnome-terminal
 2684 root       9   0 14980  14M  8716 S     1,3  6,0   0:15   0 
gnome-panel
 2653 root       9   0  7608 7604  5368 S     0,7  3,0   0:15   0 metacity
 4341 root      13   0  1020 1020   800 R     0,7  0,4   0:02   0 top
 2706 root       9   0 58848  54M 21072 S     0,3 22,6   5:39   0 
mozilla-bin
 2568 root       9   0  9548 9540  6352 S     0,1  3,8   0:00   0 
gnome-session
    1 root       8   0   472  472   424 S     0,0  0,1   0:04   0 init
    2 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 keventd
    3 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 kapmd
    4 root      18  19     0    0     0 SWN   0,0  0,0   0:00   0 
ksoftirqd_CPU0
    5 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 kswapd
    6 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 bdflush
    7 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 kupdated
    8 root     18446744073709551615 -20     0    0     0 SW<   0,0  
0,0   0:00   0 mdrecoveryd
   12 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 kjournald
   66 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 khubd
  851 root       9   0     0    0     0 SW    0,0  0,0   0:00   0 kjournald
 2018 root       8   0   896  732   620 S     0,0  0,2   0:00   0 dhclient
 2153 root       9   0   544  544   464 S     0,0  0,2   0:00   0 syslogd
 2157 root       9   0   428  424   376 S     0,0  0,1   0:00   0 klogd
 2204 root       8   0   484  480   436 S     0,0  0,1   0:00   0 apmd


