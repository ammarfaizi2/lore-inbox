Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292983AbSBVUPO>; Fri, 22 Feb 2002 15:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292976AbSBVUPG>; Fri, 22 Feb 2002 15:15:06 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:44795 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S292983AbSBVUOx>; Fri, 22 Feb 2002 15:14:53 -0500
X-Info: This message was accepted for relay by
	smtp03.mrf.mail.rcn.net as the sender used SMTP authentication
X-Trace: UmFuZG9tSVbisiotZrOl/Yuzn3YbvTGJ2qhO+H3rPFNVFYhS6APNiQXSqOPjEift9O84iRVyT8U=
Date: Fri, 22 Feb 2002 15:21:51 -0500
From: Michael B Allen <mballen@erols.com>
To: linux-kernel@vger.kernel.org, cwilkins@boinklabs.com
Subject: Re: Hard lock-ups on RH7.2 install - Via Chipset?
Message-Id: <20020222152151.0ace582f.mballen@erols.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 21, 2002 at 11:07:11AM -0500, Mark Hahn waxed eloquent:
> [...]
> > > Hi Mark,
> > > Yeah, Alan suggested his latest pre 2.4.18 kernel *might* work. Tried it,
> > > still no joy. :/
> >
> > but HOW?
> 
> How did I try it, or how no joy? ;)
> 
> On the former, I didn't run any really exhaustive tests, and Alan
> didn't suggest using or avoiding certain options. I built a relatively
> conservative kernel and then beat on all four drives with concurrent dd's.
> I also did an hdparm -tT. hdparm killed the box in a matter of a second
> or two. dd took about 30 seconds. It seems safe to assume that hdparm
> is able to create a higher load.

I have VIA KT133 no raid and I'm happily running RH 7.2 with their
stock kernel. I previously had issues that turned out to be a bad 30G
IBM DeathStar but upgraded the BIOS and did a little torture testing
out of paranoia (tried copying ~150MB files across two drives (not the
bad IBM one, they replaced it)) and I never had a problem since.

[root@nano root]# hdparm -tT /dev/sda
 Timing buffer-cache reads:   128 MB in  1.12 seconds =114.29 MB/sec
 Timing buffered disk reads:  64 MB in  5.11 seconds = 12.52 MB/sec

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 900.051
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1795.68

-- 
May The Source be with you.
