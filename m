Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264783AbTFLHNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFLHNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:13:18 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:42624 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S264783AbTFLHNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:13:16 -0400
Message-ID: <1055402824.3ee82b4865ab7@support.tuxbox.dk>
Date: Thu, 12 Jun 2003 09:27:04 +0200
From: Martin List-Petersen <martin@list-petersen.dk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
References: <87n0go3pcp.fsf@complete.org> <20030612061803.GA21509@suse.de>
In-Reply-To: <20030612061803.GA21509@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citat Dave Jones <davej@codemonkey.org.uk>:

> On Wed, Jun 11, 2003 at 11:13:26PM -0500, John Goerzen wrote:
> 
>  > I am running on a Thinkpad T40p laptop, which has a 1.6GHz Intel
>  > Pentium M CPU (this is their "Centrino" CPU; *NOT* the same thing as
>  > the Pentium 4 M).
> 
> Stay tuned. Jeremy Fitzhardinge wrote a driver for centrino style
> speedstep. It's currently getting the kinks worked out on the cpufreq list.
> It should turn up in 2.5 sometime real soon, and at some point, maybe
> someone will backport it.
> 
>  > While we're at it, I'm concerned that Linux is ignoring the sizable
>  > cache available on this platform:
>  > 
>  > $ cat /proc/cpuinfo
>  > processor       : 0
>  > vendor_id       : GenuineIntel
>  > cpu family      : 6
>  > model           : 9
>  > model name      : Intel(R) Pentium(R) M processor 1600MHz
>  > stepping        : 5
>  > cpu MHz         : 1598.686
>  > cache size      : 0 KB
> 
> Looks like missing cache descriptors. Grab x86info[1] and mail me
> the output of x86info -c
> 

Got the same thing here on a Dell Latitude D600

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Intel(R) Pentium(R) M processor 1600MHz
stepping	: 5
cpu MHz		: 1594.855
cache size	: 0 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts
acpi mmx fxsr sse sse2 tm
bogomips	: 3185.04

x86info will follow (just want to upgrade my kernel first, the thing is on
2.4.21-rc2-ac2 now)

Regards,
Martin List-Petersen
martin at list-petersen dot dk
--
Talkers are no good doers.
		-- William Shakespeare, "Henry VI"
