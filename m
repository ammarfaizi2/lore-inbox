Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVBOFuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVBOFuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 00:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVBOFuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 00:50:51 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:56260 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261633AbVBOFua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 00:50:30 -0500
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
	release)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       Roland Dreier <roland@topspin.com>, Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42116EAF.4070503@why.dont.jablowme.net>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>  <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>
	 <1108430245.32293.16.camel@krustophenia.net>
	 <42116EAF.4070503@why.dont.jablowme.net>
Content-Type: text/plain
Message-Id: <1108446753.3666.28.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 15 Feb 2005 16:52:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah Jim.

On Tue, 2005-02-15 at 14:38, Jim Crilly wrote:
> I agree boot up is too slow and that some things should be started in the 
> background, but not things that are required for the main purpose of the box to 
> work properly, what should be started sync and what should be async is a hard 
> decision IMO. Right now I use swsusp2 to work around this, it takes less time 
> to resume my session + 500M of file cache than it does to boot manually and 

You warmed my heart until...

> start all of my apps back up, but obviously that's not a real solution.

Why not? :> I guess you mean to the problem of slow booting in the first
place - I would agree with you there, but is there are reason why we
should have booting being the norm instead of normally suspending and
resuming, and only rebooting for new kernels/hardware/etc.

Regards,

Nigel

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

