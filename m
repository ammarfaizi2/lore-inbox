Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRCXVyH>; Sat, 24 Mar 2001 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131833AbRCXVx6>; Sat, 24 Mar 2001 16:53:58 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:26497 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131832AbRCXVxv>; Sat, 24 Mar 2001 16:53:51 -0500
Date: Sat, 24 Mar 2001 22:53:08 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alex Riesen <vmagic@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI power-off doesn't work on Asus CUV4X (VIA Apollo 133)
Message-ID: <20010324225308.Y11126@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010324182516.A1255@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010324182516.A1255@steel>; from vmagic@users.sourceforge.net on Sat, Mar 24, 2001 at 06:25:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2001 at 06:25:16PM +0100, Alex Riesen wrote:
> As i recompiled 2.4.2-ac20 with ACPI support
> the system cannot switch itself off.
> With APM it work without any problem.
 
APM doesn't work for me either.

> I get a message "Couldn't switch to S5" if
> try to call reboot(2).
> At load it shows that the mode is supported.

Same with AMR P6BAP-AP and P6VAP-AP () mainboards.

Firmware supports C2 C3 S0 S1 S4 S5.

All options for acpi tried.

#define APCI_DEBUG 1 has NO effect on verbosity of messages :-(

What should I do to get more debug info?

I'll try backing out all changes between 2.4.0 and 2.4.2-ac20,
because there it worked ;-)

Regards

Ingo Oeser

cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 6
model name      : VIA Samuel
stepping        : 0
cpu MHz         : 501.155
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr mce cx8 mtrr pge mmx 3dnow
bogomips        : 999.42

-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
