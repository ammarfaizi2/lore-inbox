Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVBOGPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVBOGPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 01:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVBOGPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 01:15:45 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62867 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261637AbVBOGPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 01:15:39 -0500
Message-ID: <42119380.2080309@why.dont.jablowme.net>
Date: Tue, 15 Feb 2005 01:15:28 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
Cc: Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       Roland Dreier <roland@topspin.com>, Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>	 <20050211011609.GA27176@suse.de>	 <1108354011.25912.43.camel@krustophenia.net>	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>	 <1108422240.28902.11.camel@krustophenia.net>  <524qge20e2.fsf@topspin.com>	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>	 <1108430245.32293.16.camel@krustophenia.net>	 <42116EAF.4070503@why.dont.jablowme.net> <1108446753.3666.28.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108446753.3666.28.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham said the following:
> You warmed my heart until...

Good to know someone reads my email =)

> Why not? :> I guess you mean to the problem of slow booting in the first
> place - I would agree with you there, but is there are reason why we
> should have booting being the norm instead of normally suspending and
> resuming, and only rebooting for new kernels/hardware/etc.

Don't get me wrong, I would go nuts without swsusp2 on my notebook and I don't 
see why that shouldn't be a valid avenue to pursue; even for servers it doesn't 
seem like a terribly bad idea. But for me it only works on 1 out of my 4 
machines. The 3 non-working machines have their root and swap on SCSI devices 
and to top it off 2 of them are non-x86 architectures.

Another issue would be dual-booting, which a lot of people still do for some 
strange reason. At least I had noticed that Windows tends to have problems when 
filesystems it had mounted before the hibernation are altered while it's not 
running. I'm not sure if similar issues would apply to Linux, hell I'm not even 
sure if it still applies to Windows because that was so long ago that I had 
noticed.

> 
> Regards,
> 
> Nigel
> 

Jim.
