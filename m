Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLBNqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLBNqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:46:54 -0500
Received: from k1.dinoex.de ([80.237.200.138]:59592 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S262081AbTLBNqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:46:49 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: ianh@iahastie.clara.net
Subject: Re: [2.6] Missing L2-cache after warm boot
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <87ptf8bpnd.fsf@echidna.jochen.org> <200312020300.13067.ianh@iahastie.local.net>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Tue, 02 Dec 2003 14:26:20 +0100
In-Reply-To: <200312020300.13067.ianh@iahastie.local.net> (Ian Hastie's
 message of "Tue, 2 Dec 2003 03:00:11 +0000")
Message-ID: <878ylvjqpv.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Hastie <ianh@iahastie.clara.net> writes:

> On Monday 01 Dec 2003 14:04, Jochen Hein wrote:
>> I'm running 2.6.0-test11 on an older Thinkpad 390E,
>> When booting into 2.6.0-test11 after running Windows2000 I get:
>
> Do any of the previous test releases show this problem?  

-test11 is the first release running on that machine.  My older TP600
destroyed its WIndows 95 so I got a replacement.  Compiling a kernel
takes an hour or two, so it is not much fun trying different kernels.

> How are you booting  
> Linux?  Full warm boot via the BIOS or some loadlin kind of boot?  

via BIOS, lilo in MBR

> If it's 
> via the BIOS then does that show the L2 cache as being present?

The BIOS doesn't tell anything, the setup doesn't have a "cache
enable" or "turbo" entry.

>> When booting cold the boot messages are:
>
> Presumably from switch on.

Yes.

>> /proc/cpuinfo contains (after warm boot):
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 6
>> model name      : Mobile Pentium II
>> stepping        : 10
>> cpu MHz         : 298.598
>> cache size      : 256 KB
>
> And shows as 0 after warm boot?

Hm, can't say for sure, because it didn't happen again.

> My immediate thought was a BIOS problem.  IBM's web site doesn't say any BIOS 
> updates fix L2 cache related problems, but then it doesn't seem to use 
> technical descriptions like that.  It says the latest BIOS is 1.55 - R01_C9.
>
> http://www-1.ibm.com/support/docview.wss?rs=0&uid=psg1MIGR-4F3VKB&loc=en_US

I'll see what BIOS I have - it is the latest.  Thanks for the hint anyway.

> Or maybe it's possible that something in MS Windows 2000 is turning off the L2 
> cache and it isn't getting reactivated by the warm boot?  

Is there any way to see what Windows does here?  I only found a manual
enable of the L2cache when using older processors.

> What happens when 
> you do a cold boot to Linux then reboot from there?

That is fine.

For now the system seems to be fine, even when starting from Win2k via
BIOS reboot.  Hmpf.

Jochen

-- 
#include <~/.signature>: permission denied
