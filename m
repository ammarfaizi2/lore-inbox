Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136283AbRDVUDB>; Sun, 22 Apr 2001 16:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136291AbRDVUCv>; Sun, 22 Apr 2001 16:02:51 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:49061 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136283AbRDVUCe>; Sun, 22 Apr 2001 16:02:34 -0400
Date: Sun, 22 Apr 2001 22:02:31 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: dusty@strike.wu-wien.ac.at
Cc: Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
Message-ID: <20010422220231.P682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AE1860A.390E301@violin.dyndns.org> <20010421180435.A22420@pingi.muc.suse.de> <3AE2A2D0.80388594@violin.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AE2A2D0.80388594@violin.dyndns.org>; from dusty@violin.dyndns.org on Sun, Apr 22, 2001 at 11:22:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 11:22:24AM +0200, Hermann Himmelbauer wrote:
> Karsten Keil wrote:
> > 
> > I have here the same board with 2*233 MMX and don't see this kind of ISDN
> > error on recent 2.2 kernels, but got also lot of APIC errors with the
> > 2.3/2.4, because the APIC errors are only reported in 2.3/4.
> 
> Right - same behavior here, no APIC errors with 2.2 (as they are not
> reported). The ISDN error happens very seldom (4 times last year) and is
> not reproducable - which is not so with the eth0 errors (as eth0 locks
> at around 500-1000MB while copying data).

I had a similar problem, but with less RAM than you have, I think.
And it hung the whole machine that heavy, that not even SysRq was
responding.

On that machine I had no swap installed and only 64MB of RAM.
Adding just another 64MB of RAM made it go away.

This might be an VM-skb-interaction-issue, but I saw no solution
so far.

The problem persistent with several processor (Cyrix III, Intel
Pentium (MXX), AMD Duron), several Chipsets (VIA-598, Intel BX)
and 3 different NICs (Realtek 8139, 3c509TX, Ether Express Pro)
and only under 100MBit.

I could copy MANY files (smb, scp, ftp), but ONE single file with
about 60MB or more (I tried to receive ISO images) killed the
machine. The behavior was also very random. Twice I got a
panic, but had problems writing it down due to the screen
darkening because of APM or setting "reboot on panic" :-(

Just FYI.

I don't know, why adding 64MB made it go away. I tried very hard
to reproduce it with 128MB, but really couldn't :-(

Regards 

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
