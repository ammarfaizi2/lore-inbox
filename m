Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281823AbRKWJTY>; Fri, 23 Nov 2001 04:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282085AbRKWJTF>; Fri, 23 Nov 2001 04:19:05 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:41481 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S281823AbRKWJS6>;
	Fri, 23 Nov 2001 04:18:58 -0500
Subject: Re: Thinkpad t21 hard lockup when left overnight
From: Shaya Potter <spotter@cs.columbia.edu>
To: Shaya Potter <spotter@opus.cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1006489548.10497.8.camel@zaphod>
In-Reply-To: <Pine.LNX.4.42.0111231154580.16590-100000@boston.corp.fedex.com> 
	<1006489548.10497.8.camel@zaphod>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 23 Nov 2001 04:18:38 -0500
Message-Id: <1006507120.627.0.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just woke up to a locked up solid machine.  It seemed to have locked up
after about 2 hours of inactivity on the machine.

shaya

On Thu, 2001-11-22 at 23:25, Shaya Potter wrote:
> On Thu, 2001-11-22 at 23:14, Jeff Chua wrote:
> > 
> > 
> > On 22 Nov 2001, Shaya Potter wrote:
> > 
> > > /usr/sbin/apmd -P /etc/apm/apmd_proxy
> > 
> > What version of apmd? My says "apmd version 3.0final"
> 
> same :)
> 
> spotter@zaphod:~$ dpkg --status apmd |grep Version
> Version: 3.0.1-1
> 
> > 
> > You might want to call IBM to check if there's a more recent bios upgrade
> > that you can get. Check for T21 at the IBM site below ...
> > 
> >  http://www.pc.ibm.com/support?lang=en_US&page=brand&brand=IBM+ThinkPad
> > 
> > Look for T21 under the device driver file matrices.
> > 
> > (Fix) Hang up occurs when suspend/resume is done on a ThinkPad
> > with HDD adapter without a hard disk drive in the ultrabay 2000.
> > (Fix) ACPI compatible Linux hangs up at boot timing.
> 
> I have a fairly recent version.  I boot it into windows for class once
> or twice a week (shoot me, I find it easier to take notes in MS Word,
> than in AbiWord), and since the classroom is wired for wireless ethernet
> I usually use that time to use IBM's automated utility to check for
> updates, and it checks and updates the bios appropriatly if there are
> any updates.
> 
> > 
> > My /usr/src/linux/.config ...
> > 
> > # CONFIG_ACPI is not set
> > CONFIG_APM=m
> > # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> all same
> > CONFIG_APM_DO_ENABLE=y
> different
> > CONFIG_APM_CPU_IDLE=y
> same
> > # CONFIG_APM_DISPLAY_BLANK is not set
> different
> > # CONFIG_APM_RTC_IS_GMT is not set
> (same)
> > # CONFIG_APM_ALLOW_INTS is not set
> (different)
> > # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> (same)
> 
> will try adjusting them to your values, and seeing if it locks up on me
> tonight :)
> 
> shaya
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
spotter@{cs.columbia.edu,yucs.org}
http://yucs.org/~spotter/

