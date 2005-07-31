Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVGaWS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVGaWS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGaWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:18:58 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:19882 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261994AbVGaWSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:18:23 -0400
Message-ID: <42ED4E2B.8050107@andrew.cmu.edu>
Date: Sun, 31 Jul 2005 18:18:19 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>	 <1122678943.9381.44.camel@mindpipe>	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>	 <42ED32D3.9070208@andrew.cmu.edu>  <20050731211020.GB27433@elf.ucw.cz> <1122847366.13000.15.camel@mindpipe>
In-Reply-To: <1122847366.13000.15.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sun, 2005-07-31 at 23:10 +0200, Pavel Machek wrote:
>>defconfig on i386 is Linus' configuration. Maybe server-config and
>>laptop-config would be good idea...
> 
> Um, what about those things called "desktops"?  They're like a laptop
> but with reasonable hard drive speeds and adult-sized keyboards?

Pavel picked up that (incomplete) list up from my email, and I was just 
assuming defconfig to be the desktop config.  If that feature were done 
cleanly though, we could have any number of blah-configs, and maybe even 
split desktops into low-latency or low-resources options.  It'd be neat 
to get preempt and everything on just by saying:
   make desktop-lowlatency-config
Then again, maybe that idea will fly like pigs; we'll see.

  - Jim Bruce
