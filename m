Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270569AbRHSPqi>; Sun, 19 Aug 2001 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270571AbRHSPq2>; Sun, 19 Aug 2001 11:46:28 -0400
Received: from relay.kiev.sovam.com ([212.109.32.5]:17424 "EHLO
	relay.kiev.sovam.com") by vger.kernel.org with ESMTP
	id <S270569AbRHSPqM>; Sun, 19 Aug 2001 11:46:12 -0400
Date: Sun, 19 Aug 2001 18:51:20 +0300
From: "Serguei I. Ivantsov" <administrator@svitonline.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Serguei I. Ivantsov" <administrator@svitonline.com>
Organization: IvantSoft Inc.
X-Priority: 3 (Normal)
Message-ID: <80346034.20010819185120@svitonline.com>
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.4.x & Celeron = very slow system
In-Reply-To: <Pine.LNX.4.30.0108191519430.22917-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0108191519430.22917-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

Sunday, August 19, 2001, 4:22:40 PM, you wrote:

DJ> On Sun, 19 Aug 2001, Serguei I. Ivantsov wrote:

>> With 2.4.x kernel my system (Celeron (Coppermine) 850Mhz (100x8.5)
>> 256Mb i810) behaves like slow i386sx.
>>
>> For example, when I extract 25MB gzip file on 2.2.19 kernel - it
>> takes about 12 seconds, but with 2.4.8(9) - 6(!) MINUTES on the SAME
>> system...
>>
>> The only idea is that 2.4.x kernel turns off cache (L1 & L2) on
>> processor (on my cpu). How can I check it? Any ideas?

DJ> No, we don't do any such frobbing of the cache control registers.
DJ> It is enabled in the BIOS right ?
It is enabled in BIOS.
DJ> Another thing that it might be, is if you're using ACPI instead of
DJ> APM, the cpu-idle may be causing the CPU to run slower than usual
DJ> though throttling.
I'd disabled APM support at all when configuring kernel.
DJ> Although, I've not seen this happen to the extent of what you're
DJ> reporting.  If you are running with an ACPI kernel, try booting
DJ> with an APM kernel instead to see if it makes a difference.
Maybe there is some software to test which subsystem fails
(cpu,vm,etc)? Is it possible that software from RH7.0 distribution
can't work correctly with new kernel?

-- 
Best regards,
 Serguei                            mailto:administrator@svitonline.com

