Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281883AbRKWEPR>; Thu, 22 Nov 2001 23:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281882AbRKWEPH>; Thu, 22 Nov 2001 23:15:07 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:23305 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S281881AbRKWEO5>; Thu, 22 Nov 2001 23:14:57 -0500
Date: Fri, 23 Nov 2001 12:14:43 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Shaya Potter <spotter@cs.columbia.edu>
cc: Jeff Chua <jchua@fedex.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thinkpad t21 hard lockup when left overnight
In-Reply-To: <1006483403.10497.2.camel@zaphod>
Message-ID: <Pine.LNX.4.42.0111231154580.16590-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 12:14:53 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 12:14:55 PM,
	Serialize complete at 11/23/2001 12:14:55 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Nov 2001, Shaya Potter wrote:

> /usr/sbin/apmd -P /etc/apm/apmd_proxy

What version of apmd? My says "apmd version 3.0final"

You might want to call IBM to check if there's a more recent bios upgrade
that you can get. Check for T21 at the IBM site below ...

 http://www.pc.ibm.com/support?lang=en_US&page=brand&brand=IBM+ThinkPad

Look for T21 under the device driver file matrices.

(Fix) Hang up occurs when suspend/resume is done on a ThinkPad
with HDD adapter without a hard disk drive in the ultrabay 2000.
(Fix) ACPI compatible Linux hangs up at boot timing.

My /usr/src/linux/.config ...

# CONFIG_ACPI is not set
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

I don't know whether the above will help or not, but it's worth a try.

Jeff

