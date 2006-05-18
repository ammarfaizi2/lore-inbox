Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWERMEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWERMEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWERMEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:04:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:41692 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932074AbWERMEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:04:07 -0400
Message-ID: <446C61F8.7080406@aitel.hist.no>
Date: Thu, 18 May 2006 14:00:56 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux cbon <linuxcbon@yahoo.fr>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
In-Reply-To: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux cbon wrote:

> --- Valdis.Kletnieks@vt.edu a écrit : 
>  
>
>>On Wed, 17 May 2006 13:47:22 +0200, linux cbon said:
>>
>>If it isn't backward compatible, people won't use
>>it.  X may suck,
>>but it doesn't suck hard enough that people will
>>abandon all their
>>currently mostly-working software.
>>    
>>
>
>If we have a new window system, shall all applications
>be rewritten ?
>  
>
All graphical applications - sure.

>My idea is that the kernel should include universal
>graphical support.
>  
>
You contradict yourself here.  You complained that
X runs too many things as root, and is therefore unsafe.

Now you want to move graphichs into the kernel???

Don't you know that the kernel is even more privileged than
root, so anything running in the kernel is way more
dangerous than a program running as the root user?


Also note that windows runs its graphics in the kernel,
and have exactly this problem. An error in the windows
graphichs system can therefore crash the machine.

X has a harder time crashing the machine because it
is not in the kernel, but of course the root privilege
is still somewhat dangerous as you mentioned.

The real security fix would be to run X as a non-root
user, except for a hw acceleration library that
should be in a kernel driver.  This can be done without
changing the apps too - wether it is doable without
performance loss is another issue.

>And then we would NOT need ANY window system AT ALL.
>We wouldnt have 2 os (kernel and X) at the same time
>like now.
>It would be faster, simpler, easier to manage etc.
>
Your solution does not mean "no window system at all"
You still got one, except now it is in the kernel and
therefore more dangerous.  We do not have 2 os now,
because X is _not_ an os.  Please look up what an os _is_,
and you'll see that. 

Also, please tell why this would be faster, simpler, or
easier to manage.  Stuff in the kernel is generally
harder to manage than userspace stuff, and definitely
not simpler.  Kernel code lives with all sorts of requirements
and limitations that an application programmer would hate
to have to worry about. 

Helge Hafting

