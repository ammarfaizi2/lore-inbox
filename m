Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZMFP>; Fri, 26 Jan 2001 07:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAZMFF>; Fri, 26 Jan 2001 07:05:05 -0500
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129143AbRAZME7>;
	Fri, 26 Jan 2001 07:04:59 -0500
Message-ID: <20010126102302.B124@bug.ucw.cz>
Date: Fri, 26 Jan 2001 10:23:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Schmitt <alan.schmitt@inria.fr>, linux-kernel@vger.kernel.org
Subject: Re: kapm-idled and cpu heating ...
In-Reply-To: <20010122165141.A2888@alan-schm1p.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010122165141.A2888@alan-schm1p.inria.fr>; from Alan Schmitt on Mon, Jan 22, 2001 at 04:51:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've read the december thread, I've searched the web and I could not
> come out with an answer, so here I dare to ask (please cc me for any
> answer as I am not subscribed to the list, I just read the kernel
> cousin version).
> 
> I just installed 2.4.0 on my laptop (dell cpi a366x). I noticed the
> kapm-idled process, which doesn't really bother me, with one
> exception: my cpu is getting hot enough to start the fan, even without
> any load. I compiled with the apm cpu idle option (here is a quick
> grep of my .config file):
> 
> [schmitta@alan-schm1p linux]$ grep APM .config
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> 
> This behaviour, with the same options, does not occur with 2.2.18.
> 
> So my question is: how idle is kapm-idled ? Is my bios buggy ? Did I
> miss something when configuring the kernel ? Is this a really stupid
> question ;-)

kapm-idled should make cpu more cool, not more hot. Buggy bios?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
