Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSAFPb5>; Sun, 6 Jan 2002 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288972AbSAFPbs>; Sun, 6 Jan 2002 10:31:48 -0500
Received: from jester.ti.com ([192.94.94.1]:50126 "EHLO jester.ti.com")
	by vger.kernel.org with ESMTP id <S288971AbSAFPbd>;
	Sun, 6 Jan 2002 10:31:33 -0500
Message-ID: <3C386DC9.307@ti.com>
Date: Sun, 06 Jan 2002 16:31:21 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

You might remember I had issues with massive swapping and wanted to know 
whether I can control the amount of cache and buffers and so on.Well I 
thought a mem upgrade would do the trick ,but no :-(
Not easy to explain to my boss that it still crawls with 512 MB mem and 
that's the max limit in this laptop..Anyone found any solutions ?? Check 
this out:

  top -bn 1|head -n 30


  16:25:46 up  2:56,  4 users,  load average: 0.50, 0.46, 0.43
79 processes: 77 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   9.8% user,   8.5% system,   0.0% nice,  81.7% idle
Mem:    513692K total,   512072K used,     1620K free,    21564K buffers
Swap:   248968K total,    60180K used,   188788K free,   323668K cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   950 ce        14   0  150M 150M  149M R    18.2 29.9  13:01 vmware
  1146 ce        17   0  1000  996   772 R     7.3  0.1   0:00 top
   952 ce         9   0 42572 9528  8268 S     0.9  1.8   0:12 vmware-mks
     1 root       8   0   524  480   460 S     0.0  0.0   0:03 init
     2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
     3 root       9   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
     4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 
ksoftirqd_CPU0
     5 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd
     6 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
     7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    69 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreiserfsd
    92 daemon     9   0   464  380   380 S     0.0  0.0   0:00 portmap
   218 root       9   0   648  596   528 S     0.0  0.1   0:00 syslogd
   221 root       9   0  1192  460   460 S     0.0  0.0   0:00 klogd
   242 root       8   0   676  520   520 S     0.0  0.1   0:00 cardmgr
   248 root       9   0   728  620   620 S     0.0  0.1   0:00 rpc.statd
   251 root       8   0   512  508   496 S     0.0  0.0   0:00 apmd
   262 root       9   0   556  484   484 S     0.0  0.0   0:00 inetd
   307 root       9   0  1192  968   856 S     0.0  0.1   0:00 nmbd
   309 root       9   0  1168  812   812 S     0.0  0.1   0:00 smbd
   316 root       9   0  1240 1028  1028 S     0.0  0.2   0:00 sshd


it just caches like crazy and things start to crawl cause its 
swapping.More than 300 MB of cache what on earth is being cached ?? I 
can't stand ths anymore I guess I'll have to back down to 2.2 again,but 
that'll have other downsides :-(  *sigh*
I'm willing to help as much as I can with this I don't want to give up 
on Linux just like that.

best regards

Christian

