Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSA3Jbg>; Wed, 30 Jan 2002 04:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSA3Jb1>; Wed, 30 Jan 2002 04:31:27 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:28940 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289011AbSA3JbJ>; Wed, 30 Jan 2002 04:31:09 -0500
Date: Wed, 30 Jan 2002 17:27:00 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Greg Louis <glouis@dynamicro.on.ca>, <VANDROVE@vc.cvut.cz>,
        <jdthood@mail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <skraw@ithnet.com>,
        Jeff Chua <jchua@fedex.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <20020130165058.0dc3147f.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0201301723580.3268-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/30/2002
 05:31:05 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/30/2002
 05:31:07 PM,
	Serialize complete at 01/30/2002 05:31:07 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Stephen Rothwell wrote:

> Would you like to try another patch? :-)

sure, will try tonight.

> I am not seeing your problems, but then again I am running on an IBM
> Thinkpad, so I do BIOS calls with interrupts enabled and the BIOS halts
> on idle (as opposed to slowing the CPU).  I also have SpeedStep
> disabled.

I've a ThinkPad X22.

My .config ...

	CONFIG_APM=m
	# CONFIG_APM_IGNORE_USER_SUSPEND is not set
	# CONFIG_APM_DO_ENABLE is not set
	CONFIG_APM_CPU_IDLE=y
	# CONFIG_APM_DISPLAY_BLANK is not set
	# CONFIG_APM_RTC_IS_GMT is not set
	# CONFIG_APM_ALLOW_INTS is not set
	# CONFIG_APM_REAL_MODE_POWER_OFF is not set

/etc/modules.conf
	options apm idle_threshold=95 power_off=1



Jeff


