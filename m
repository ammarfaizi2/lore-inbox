Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOSra>; Fri, 15 Dec 2000 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQLOSrZ>; Fri, 15 Dec 2000 13:47:25 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:44006 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129797AbQLOSrO>; Fri, 15 Dec 2000 13:47:14 -0500
Date: Fri, 15 Dec 2000 20:16:08 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: e.jokisch@u-code.de, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: test12 lockups -- need feedback
Message-ID: <20001215201608.M829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001215194735.K829@nightmaster.csn.tu-chemnitz.de> <1368.195.67.189.102.976902742.squirrel@www.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1368.195.67.189.102.976902742.squirrel@www.zytor.com>; from hpa@zytor.com on Fri, Dec 15, 2000 at 09:52:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 09:52:22AM -0800, H. Peter Anvin wrote:
> > This was on Cyrix III.
> 
> Please include the oops information, as well as the /proc/cpuinfo output.

processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 6
model name      : WinChip ??
stepping        : 0
cpu MHz         : 501.000148
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr mce cx8 mtrr pge mmx
bogomips        : 999.42
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 6
model name      : WinChip ??
stepping        : 0
cpu MHz         : 501.000148
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr mce cx8 mtrr pge mmx
bogomips        : 999.42

Oops not available, because this machine is in a frozen state (in
project management context) running a specially patched test9.

It oopsed after this message:
CPU: Before vendor init, caps: <the actual caps>

The only symbols on stack where "empty_bad_page" and "L6" without
any offset.

I'll get access to a clone of this machine on monday and oops it
again ;-)

But perhaps this is helpful in any matter.

Regards & Thanks

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
