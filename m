Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316462AbSEOSPE>; Wed, 15 May 2002 14:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316463AbSEOSPD>; Wed, 15 May 2002 14:15:03 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:48392 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S316462AbSEOSPD>;
	Wed, 15 May 2002 14:15:03 -0400
Date: Wed, 15 May 2002 20:15:01 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with smp kernels on alpha
Message-ID: <20020515181501.GA1949@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been trying to get a Digital Server 5305 to run a SMP kernel, but I was
unsucessful till now, the machine runs 2.2.20 or 2.4.18 UP perfectly, but
crashes rigt after booting or when booting whenever I tri the SMP versions
of this kernels. This is what /proc/cpuinfo says about the machine:

cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Rawhide
system variation        : 0
system revision         : 0
system serial number    : AY92103084
cycle frequency [Hz]    : 531914893
timer frequency [Hz]    : 1200.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 923.40
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : DIGITAL Server 5000 Model 5305 6533A 5/533 4MB
cpus detected           : 2

I have tried Debian smp kernel 2.2.20 (generic cpu) and a custom 2.4.18
kernel (using generic and then rawhide) and cpu allways crashes, las time I
saw it crash I copied this:

Unable to handle kernel paging request at virtual address 0000000000000000000
cpu 0 swapper(0): Oops 0

then it outputs the registers, then trace and code and then...

Kernel panic: Attempted to kill the idle task!
In idle tak - not syncing

Well, I know this doesn't show a thing, but I'm new to alpha so I don't know
what to look at, if someone is willing to help on this I'll try to do
whatever tests are needed to provide more info.

Thanks in advance...
-- 
Manty/BestiaTester -> http://manty.net
