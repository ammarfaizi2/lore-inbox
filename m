Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276429AbRI2Dq2>; Fri, 28 Sep 2001 23:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276430AbRI2DqT>; Fri, 28 Sep 2001 23:46:19 -0400
Received: from [63.193.79.18] ([63.193.79.18]:25839 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S276429AbRI2DqO>;
	Fri, 28 Sep 2001 23:46:14 -0400
Date: Fri, 28 Sep 2001 20:46:12 -0700
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-ac10 IDE access slows as uptime increases
Message-ID: <20010928204612.A911@inxservices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I've been noticing this for months, and thought I was crazy. But I
just verified it.
   I ran a program that's a GUI app/front-end to a data base, on the
local drives. It took seconds to access a record.
   Rebooted. Ran the same thing again. The program accessed records
almost instantly.
   I get faster response time from the 2.2.20-pre2 systems over 100MBs
NFS than I do on the 2.4 system after it has been running for a few
hours. NFS is slow enough, usually use ssh and run the program on the DB
system. (Only use a local copy when testing.)
   Use the system mostly to compile, debug and test.

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 999.743
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1992.29

        total:    used:    free:  shared: buffers:  cached:
Mem:  1053401088 1002246144 51154944 10092544 51945472 798220288
Swap: 2147467264     4096 2147463168
MemTotal:      1028712 kB
MemFree:         49956 kB
MemShared:        9856 kB
Buffers:         50728 kB
Cached:         779508 kB
SwapCached:          4 kB
Active:         505116 kB
Inact_dirty:     76400 kB
Inact_clean:    258580 kB
Inact_target:      352 kB
HighTotal:      130992 kB
HighFree:         7256 kB
LowTotal:       897720 kB
LowFree:         42700 kB
SwapTotal:     2097136 kB
SwapFree:      2097132 kB

Personalities : [raid1] 
read_ahead 1024 sectors
md0 : active raid1 ide/host0/bus1/target1/lun0/part2[1] ide/host0/bus0/target0/lun0/part2[0]
      6291840 blocks [2/2] [UU]
md1 : active raid1 ide/host0/bus1/target1/lun0/part3[1] ide/host0/bus0/target0/lun0/part3[0]
      51661952 blocks [2/2] [UU]
unused devices: <none>

  8:32pm  up  1:42, 23 users,  load average: 2.87, 3.07, 2.77
All those users are me, logged into different xterms, most of which are
not being used during the uptime.

   XFree86 4.0.3. Using nVidia drivers. I really don't remember if the
problem was there when I was using an Athlon similarly configured except
for a Voodoo3 and 3/4 the RAM. Had so many problems with the Athlon, I
gave it to a co-worker who doesn't use their box as heavily as I do.
They haven't had any problems with the Athlon.
   I seem to remember this as a problem on the Athlon, too, but won't
swear to it because there were too many other things going on and this
is the first time I actually checked to see if the slowdown was real.
   Also have VMware modules loaded all the time. Don't always use it
every day though, and still see the slowdown. The system is rebooted
each morning right now, most of the time (unless I just forget). The
slowdown doesn't just affect the data base program. Its just really
noticeable there.
   Config attached. Any ideas how to check this out further?

--LZvS9be/3tNcYl/X
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--LZvS9be/3tNcYl/X--
