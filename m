Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267250AbSKPJUH>; Sat, 16 Nov 2002 04:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267251AbSKPJUH>; Sat, 16 Nov 2002 04:20:07 -0500
Received: from holomorphy.com ([66.224.33.161]:28372 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267250AbSKPJUE>;
	Sat, 16 Nov 2002 04:20:04 -0500
Date: Sat, 16 Nov 2002 01:24:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021116092424.GY22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3DA798B6.9070400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA798B6.9070400@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 08:36:22PM -0700, Dave Hansen wrote:
> Man, this looks ugly.  I'm just waiting for Bill Irwin, or Anton to 
> trump me, though.

If I may rehash, since it is O(cpus), hence 1MB of ZONE_NORMAL stacks...

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  4 18:56 ?        00:00:09 init
root         2     1  0 18:56 ?        00:00:00 [migration/0]
root         3     1  0 18:56 ?        00:00:00 [ksoftirqd/0]
root         4     1  0 18:56 ?        00:00:00 [migration/1]
root         5     1  0 18:56 ?        00:00:00 [ksoftirqd/1]
root         6     1  0 18:56 ?        00:00:00 [migration/2]
root         7     1  0 18:56 ?        00:00:00 [ksoftirqd/2]
root         8     1  0 18:56 ?        00:00:00 [migration/3]
root         9     1  0 18:56 ?        00:00:00 [ksoftirqd/3]
root        10     1  0 18:56 ?        00:00:00 [migration/4]
root        11     1  0 18:56 ?        00:00:00 [ksoftirqd/4]
root        12     1  0 18:56 ?        00:00:00 [migration/5]
root        13     1  0 18:56 ?        00:00:00 [ksoftirqd/5]
root        14     1  0 18:56 ?        00:00:00 [migration/6]
root        15     1  0 18:56 ?        00:00:00 [ksoftirqd/6]
root        16     1  0 18:56 ?        00:00:00 [migration/7]
root        17     1  0 18:56 ?        00:00:00 [ksoftirqd/7]
root        18     1  0 18:56 ?        00:00:00 [migration/8]
root        19     1  0 18:56 ?        00:00:00 [ksoftirqd/8]
root        20     1  0 18:56 ?        00:00:00 [migration/9]
root        21     1  0 18:56 ?        00:00:00 [ksoftirqd/9]
root        22     1  0 18:56 ?        00:00:00 [migration/10]
root        23     1  0 18:56 ?        00:00:00 [ksoftirqd/10]
root        24     1  0 18:56 ?        00:00:00 [migration/11]
root        25     1  0 18:56 ?        00:00:00 [ksoftirqd/11]
root        26     1  0 18:56 ?        00:00:00 [migration/12]
root        27     1  0 18:56 ?        00:00:00 [ksoftirqd/12]
root        28     1  0 18:56 ?        00:00:00 [migration/13]
root        29     1  0 18:56 ?        00:00:00 [ksoftirqd/13]
root        30     1  0 18:56 ?        00:00:00 [migration/14]
root        31     1  0 18:56 ?        00:00:00 [ksoftirqd/14]
root        32     1  0 18:56 ?        00:00:00 [migration/15]
root        33     1  0 18:56 ?        00:00:00 [ksoftirqd/15]
root        34     1  0 18:56 ?        00:00:00 [migration/16]
root        35     1  0 18:56 ?        00:00:00 [ksoftirqd/16]
root        36     1  0 18:56 ?        00:00:00 [migration/17]
root        37     1  0 18:56 ?        00:00:00 [ksoftirqd/17]
root        38     1  0 18:56 ?        00:00:00 [migration/18]
root        39     1  0 18:56 ?        00:00:00 [ksoftirqd/18]
root        40     1  0 18:56 ?        00:00:00 [migration/19]
root        41     1  0 18:56 ?        00:00:00 [ksoftirqd/19]
root        42     1  0 18:56 ?        00:00:00 [migration/20]
root        43     1  0 18:56 ?        00:00:00 [ksoftirqd/20]
root        44     1  0 18:56 ?        00:00:00 [migration/21]
root        45     1  0 18:56 ?        00:00:00 [ksoftirqd/21]
root        46     1  0 18:56 ?        00:00:00 [migration/22]
root        47     1  0 18:56 ?        00:00:00 [ksoftirqd/22]
root        48     1  0 18:56 ?        00:00:00 [migration/23]
root        49     1  0 18:56 ?        00:00:00 [ksoftirqd/23]
root        50     1  0 18:56 ?        00:00:00 [migration/24]
root        51     1  0 18:56 ?        00:00:00 [ksoftirqd/24]
root        52     1  0 18:56 ?        00:00:00 [migration/25]
root        53     1  0 18:56 ?        00:00:00 [ksoftirqd/25]
root        54     1  0 18:56 ?        00:00:00 [migration/26]
root        55     1  0 18:56 ?        00:00:00 [ksoftirqd/26]
root        56     1  0 18:56 ?        00:00:00 [migration/27]
root        57     1  0 18:56 ?        00:00:00 [ksoftirqd/27]
root        58     1  0 18:56 ?        00:00:00 [migration/28]
root        59     1  0 18:56 ?        00:00:00 [ksoftirqd/28]
root        60     1  0 18:56 ?        00:00:00 [migration/29]
root        61     1  0 18:56 ?        00:00:00 [ksoftirqd/29]
root        62     1  0 18:56 ?        00:00:00 [migration/30]
root        63     1  0 18:56 ?        00:00:00 [ksoftirqd/30]
root        64     1  0 18:56 ?        00:00:00 [migration/31]
root        65     1  0 18:56 ?        00:00:00 [ksoftirqd/31]
root        66     1  0 18:56 ?        00:00:00 [events/0]
root        67     1  0 18:56 ?        00:00:00 [events/1]
root        68     1  0 18:56 ?        00:00:00 [events/2]
root        69     1  0 18:56 ?        00:00:00 [events/3]
root        70     1  0 18:56 ?        00:00:00 [events/4]
root        71     1  0 18:56 ?        00:00:00 [events/5]
root        72     1  0 18:56 ?        00:00:00 [events/6]
root        73     1  0 18:56 ?        00:00:00 [events/7]
root        74     1  0 18:56 ?        00:00:00 [events/8]
root        75     1  0 18:56 ?        00:00:00 [events/9]
root        76     1  0 18:56 ?        00:00:00 [events/10]
root        77     1  0 18:56 ?        00:00:00 [events/11]
root        78     1  0 18:56 ?        00:00:00 [events/12]
root        79     1  0 18:56 ?        00:00:00 [events/13]
root        80     1  0 18:56 ?        00:00:00 [events/14]
root        81     1  0 18:56 ?        00:00:00 [events/15]
root        82     1  0 18:56 ?        00:00:00 [events/16]
root        83     1  0 18:56 ?        00:00:00 [events/17]
root        84     1  0 18:56 ?        00:00:00 [events/18]
root        85     1  0 18:56 ?        00:00:00 [events/19]
root        86     1  0 18:56 ?        00:00:00 [events/20]
root        87     1  0 18:56 ?        00:00:00 [events/21]
root        88     1  0 18:56 ?        00:00:00 [events/22]
root        89     1  0 18:56 ?        00:00:00 [events/23]
root        90     1  0 18:56 ?        00:00:00 [events/24]
root        91     1  0 18:56 ?        00:00:00 [events/25]
root        92     1  0 18:56 ?        00:00:00 [events/26]
root        93     1  0 18:56 ?        00:00:00 [events/27]
root        94     1  0 18:56 ?        00:00:00 [events/28]
root        95     1  0 18:56 ?        00:00:00 [events/29]
root        96     1  0 18:56 ?        00:00:00 [events/30]
root        97     1  0 18:56 ?        00:00:00 [events/31]
root       105     1  0 18:56 ?        00:00:00 [kswapd0]
root       104     1  0 18:56 ?        00:00:00 [kswapd1]
root       103     1  0 18:56 ?        00:00:00 [kswapd2]
root       102     1  0 18:56 ?        00:00:00 [kswapd3]
root       100     1  0 18:56 ?        00:00:00 [kswapd5]
root       101     1  0 18:56 ?        00:00:00 [kswapd4]
root        99     1  0 18:56 ?        00:00:00 [kswapd6]
root        98     1  0 18:56 ?        00:00:00 [kswapd7]
root       106     1  1 18:56 ?        00:00:03 [pdflush]
root       107     1  1 18:56 ?        00:00:03 [pdflush]
root       108     1  0 18:56 ?        00:00:00 [aio/0]
root       109     1  0 18:56 ?        00:00:00 [aio/1]
root       110     1  0 18:56 ?        00:00:00 [aio/2]
root       111     1  0 18:56 ?        00:00:00 [aio/3]
root       112     1  0 18:56 ?        00:00:00 [aio/4]
root       113     1  0 18:56 ?        00:00:00 [aio/5]
root       114     1  0 18:56 ?        00:00:00 [aio/6]
root       115     1  0 18:56 ?        00:00:00 [aio/7]
root       116     1  0 18:56 ?        00:00:00 [aio/8]
root       117     1  0 18:56 ?        00:00:00 [aio/9]
root       118     1  0 18:56 ?        00:00:00 [aio/10]
root       119     1  0 18:56 ?        00:00:00 [aio/11]
root       120     1  0 18:56 ?        00:00:00 [aio/12]
root       121     1  0 18:56 ?        00:00:00 [aio/13]
root       122     1  0 18:56 ?        00:00:00 [aio/14]
root       123     1  0 18:56 ?        00:00:00 [aio/15]
root       124     1  0 18:56 ?        00:00:00 [aio/16]
root       125     1  0 18:56 ?        00:00:00 [aio/17]
root       126     1  0 18:56 ?        00:00:00 [aio/18]
root       127     1  0 18:56 ?        00:00:00 [aio/19]
root       128     1  0 18:56 ?        00:00:00 [aio/20]
root       129     1  0 18:56 ?        00:00:00 [aio/21]
root       130     1  0 18:56 ?        00:00:00 [aio/22]
root       131     1  0 18:56 ?        00:00:00 [aio/23]
root       132     1  0 18:56 ?        00:00:00 [aio/24]
root       133     1  0 18:56 ?        00:00:00 [aio/25]
root       134     1  0 18:56 ?        00:00:00 [aio/26]
root       135     1  0 18:56 ?        00:00:00 [aio/27]
root       136     1  0 18:56 ?        00:00:00 [aio/28]
root       137     1  0 18:56 ?        00:00:00 [aio/29]
root       138     1  0 18:56 ?        00:00:00 [aio/30]
root       139     1  0 18:56 ?        00:00:00 [aio/31]
root       140     1  0 18:56 ?        00:00:00 [scsi_eh_0]
root       320     1  0 18:56 ?        00:00:00 /sbin/syslogd
root       323     1  0 18:56 ?        00:00:00 /sbin/klogd
root       330     1  0 18:56 ?        00:00:00 /usr/sbin/inetd
root       334     1  0 18:56 ?        00:00:00 /usr/sbin/netserver
root       340     1  0 18:56 ?        00:00:00 /usr/sbin/sshd
root       343     1  0 18:56 ?        00:00:00 /usr/sbin/ntpd
root       346     1  0 18:56 tty1     00:00:00 /sbin/getty 38400 tty1
root       347     1  0 18:56 tty2     00:00:00 /sbin/getty 38400 tty2
root       348     1  0 18:56 tty3     00:00:00 /sbin/getty 38400 tty3
root       349     1  0 18:56 tty4     00:00:00 /sbin/getty 38400 tty4
root       350     1  0 18:56 tty5     00:00:00 /sbin/getty 38400 tty5
root       351     1  0 18:56 tty6     00:00:00 /sbin/getty 38400 tty6
root       352     1  0 18:56 ttyS0    00:00:00 -bash
root       354   340  0 18:57 ?        00:00:00 /usr/sbin/sshd
wli        356   354  0 18:57 ?        00:00:00 /usr/sbin/sshd
wli        357   356  0 18:57 pts/0    00:00:00 -zsh
root       360   340  0 18:57 ?        00:00:00 /usr/sbin/sshd
wli        362   360  0 18:57 ?        00:00:00 /usr/sbin/sshd
wli        363   362  0 18:57 pts/1    00:00:00 -zsh
root       366   340  0 18:57 ?        00:00:00 /usr/sbin/sshd
wli        368   366  0 18:57 ?        00:00:00 /usr/sbin/sshd
wli        369   368  0 18:57 pts/2    00:00:00 -zsh
wli       4435   363  0 18:59 pts/1    00:00:00 ps -fade
wli       4436   363  0 18:59 pts/1    00:00:00 less


Hmm, is there any hope left for state machines?


Bill

P.S.:	I'd also love to see make -j64 bzImage take 26s like on 16x
	instead of 48s as it appears to be doing on 32x. Doubling
	num_cpus_online() shouldn't double kernel kernel compile time.
