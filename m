Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVBON3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVBON3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVBON3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:29:55 -0500
Received: from [195.23.16.24] ([195.23.16.24]:32951 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261719AbVBON3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:29:53 -0500
Message-ID: <4211F90F.5030705@grupopie.com>
Date: Tue, 15 Feb 2005 13:28:47 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Kyle Moffett <mrmacman_g4@mac.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>	 <20050211011609.GA27176@suse.de>	 <1108354011.25912.43.camel@krustophenia.net>	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>	 <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com>	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>	 <1108430245.32293.16.camel@krustophenia.net>	 <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>	 <4211B8FC.8000600@aitel.hist.no> <1108459982.438.9.camel@tara.firmix.at> <4211F706.4030104@aitel.hist.no>
In-Reply-To: <4211F706.4030104@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Now that is a really good idea.  Init could simply run "make -j init2" to
> enter runlevel 2.  A suitable makefile would list all dependencies, and
> of course the targets needed for "init2", "init3" and so on.
> 
> It might not be that much work either.  Parallel make exists already, 
> and the
> first attempt at a makefile could simply implement the current sequence 
> that
> is known to work. Then the tweaking comes. :-)

Someone already mentioned this work before on this thread. I just 
googled for it and found the link:

http://www-106.ibm.com/developerworks/linux/library/l-boot.html?ca=dgr-lnxw04BootFaster

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
