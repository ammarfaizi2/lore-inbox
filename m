Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281985AbRKWE01>; Thu, 22 Nov 2001 23:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281904AbRKWE0S>; Thu, 22 Nov 2001 23:26:18 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:28169 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S281886AbRKWE0F>;
	Thu, 22 Nov 2001 23:26:05 -0500
Subject: Re: Thinkpad t21 hard lockup when left overnight
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0111231154580.16590-100000@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.42.0111231154580.16590-100000@boston.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 22 Nov 2001 23:25:47 -0500
Message-Id: <1006489548.10497.8.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 23:14, Jeff Chua wrote:
> 
> 
> On 22 Nov 2001, Shaya Potter wrote:
> 
> > /usr/sbin/apmd -P /etc/apm/apmd_proxy
> 
> What version of apmd? My says "apmd version 3.0final"

same :)

spotter@zaphod:~$ dpkg --status apmd |grep Version
Version: 3.0.1-1

> 
> You might want to call IBM to check if there's a more recent bios upgrade
> that you can get. Check for T21 at the IBM site below ...
> 
>  http://www.pc.ibm.com/support?lang=en_US&page=brand&brand=IBM+ThinkPad
> 
> Look for T21 under the device driver file matrices.
> 
> (Fix) Hang up occurs when suspend/resume is done on a ThinkPad
> with HDD adapter without a hard disk drive in the ultrabay 2000.
> (Fix) ACPI compatible Linux hangs up at boot timing.

I have a fairly recent version.  I boot it into windows for class once
or twice a week (shoot me, I find it easier to take notes in MS Word,
than in AbiWord), and since the classroom is wired for wireless ethernet
I usually use that time to use IBM's automated utility to check for
updates, and it checks and updates the bios appropriatly if there are
any updates.

> 
> My /usr/src/linux/.config ...
> 
> # CONFIG_ACPI is not set
> CONFIG_APM=m
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
all same
> CONFIG_APM_DO_ENABLE=y
different
> CONFIG_APM_CPU_IDLE=y
same
> # CONFIG_APM_DISPLAY_BLANK is not set
different
> # CONFIG_APM_RTC_IS_GMT is not set
(same)
> # CONFIG_APM_ALLOW_INTS is not set
(different)
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
(same)

will try adjusting them to your values, and seeing if it locks up on me
tonight :)

shaya



