Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbRD2AAJ>; Sat, 28 Apr 2001 20:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132707AbRD1X7u>; Sat, 28 Apr 2001 19:59:50 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:61104 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S132686AbRD1X7k>; Sat, 28 Apr 2001 19:59:40 -0400
Message-ID: <3AEB5969.6FB678B4@bigfoot.com>
Date: Sat, 28 Apr 2001 16:59:37 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-intel-smp-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: idalton@ferret.phonewave.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu> <20010429011604.A976@home.ds9a.nl> <20010428160954.A25712@ferret.phonewave.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Obvious question is, which compiler.
> 
> I hadn't seen any locks, but (on a dual Pmmx 200) it started crawling
> right after the NIC module (tulip) was loaded. System load decided to
> skyrocket.
> 
> Yadda... 2.2.19 with devfs patch.
> bicycle:~# gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.3/specs
> gcc version 2.95.3 20010315 (Debian release)
> 
> Might be the same problem.

Twin Abit BP6's, 2.2.19 + 9-Apr ide patch, no problems.

egcs-2.91.66

tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Lite-On 82c168 PNIC rev 32 at 0xc800, 00:A0:CC:57:89:93, IRQ 16.

-- 
  |  650.390.9613  |  6502247437@messaging.cellone-sf.com
