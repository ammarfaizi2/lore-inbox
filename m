Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWDTVDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWDTVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWDTVDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:03:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47240 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751314AbWDTVDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:03:08 -0400
Subject: Re: rtc: lost some interrupts at 256Hz
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Monnerie <michael.monnerie@it-management.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604202237.34134@zmi.at>
References: <200604202237.34134@zmi.at>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 17:03:02 -0400
Message-Id: <1145566983.5412.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 22:37 +0200, Michael Monnerie wrote:
> When you google for such messages, you can find a lot of people asking, 
> but nobody seems to have an answer. That's why I ask this list, where 
> the Godfathers Of Linux reside, and maybe someone hears my prayer and 
> could explain us sheep what you should do in such a case. Increase the 
> HZ from 250 to 1000, or decrease to 100? Or maybe setting the 
> preemption model from server to voluntary or preemptible? Or is that 
> whining to be ignored, and if yes, what is this message for at all?
> 
> Please give us wisdom, and we will spread your word. Amen.
> 
> Answers please per PM, I'm not on this list.
> 
> mfg zmi *or could you ask in a nicer way?*

Changing the preemption model to voluntary or full preemption could
certainly help.  What app is using the RTC, mplayer?

Lee

