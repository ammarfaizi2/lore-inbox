Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVBOAR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVBOAR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVBOAR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:17:26 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:38348 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261388AbVBOARV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:17:21 -0500
Message-ID: <42113F6B.1080602@am.sony.com>
Date: Mon, 14 Feb 2005 16:16:43 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Roland Dreier <roland@topspin.com>, Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>	 <20050211011609.GA27176@suse.de>	 <1108354011.25912.43.camel@krustophenia.net>	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>	 <1108422240.28902.11.camel@krustophenia.net>  <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net>
In-Reply-To: <1108424720.32293.8.camel@krustophenia.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> But, I was referring more to things like GDM not being started until all
> the other init scripts are done.  Why not start it first, and let the
> network initialize while the user is logging in?

There are a number of techniques used by CE vendors to get fast bootup
time.  Some CE products boot Linux in under 1 second.  Sony's
best Linux boot time in the lab (from power on to user space)
was 148 milliseconds, on an ARM chip (running at 200 MHZ I believe).

Every product I know of that boots in under 1 second does it
by completely eliminating RC scripts, and using a custom init
program.

For anyone interested, CELF has some resources on this topic at:
http://tree.celinuxforum.org/CelfPubWiki/BootupTimeResources

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
