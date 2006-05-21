Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWEUWmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWEUWmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWEUWmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:42:13 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:11474 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751542AbWEUWmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:42:11 -0400
Message-ID: <4470A475.7040106@m1k.net>
Date: Sun, 21 May 2006 13:33:41 -0400
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hermann pitton <hermann-pitton@arcor.de>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-dvb-maintainer@linuxtv.org, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [PATCH 00/33] V4L/DVB bug fixes
References: <20060513094537.PS23916900000@infradead.org>	<446F6F46.9090605@m1k.net> <1148180387.4222.13.camel@pc08.localdom.local>
In-Reply-To: <1148180387.4222.13.camel@pc08.localdom.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hermann pitton wrote:

>Am Samstag, den 20.05.2006, 15:34 -0400 schrieb Michael Krufky:
>  
>
>>mchehab@infradead.org wrote:
>>
>>>Please pull these from master branch at:
>>>       kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
>>>
>>Linus,
>>
>>A week has gone by... Do you intend to merge these bug fixes into your tree?
>>
>>These changesets fix a whole bunch of serious bugs that have been 
>>introduced in 2.6.17, and a good many of these bugfixes have been 
>>sitting around, waiting to be merged since 2.6.17-rc1, not to mention 
>>the fixes that have already been merged much earlier in 2.6.16.y
>>
>>Please merge these before 2.6.17-rc5
>>
>>We have already eliminated as many patches as we possibly could.  It all 
>>comes down to these.  Everything else has been held back until the 
>>2.6.18 merge window.
>>
>Hi Mike,
>
>I can see you are concerned and you are right.
>
>OTOH we have some load currently and I wouldn't mind to go through what
>Andrew worked out for it so far. Especially as we never had much/any
>useful from those testers, but might change if it is employed long
>enough ;)
>  
>
Hermann,

The bugfixes that I am concerned about do not include the refactoring 
changes from Andrew -- those are not even bugfixes at all, and they are 
only accessible through our mercurial tree.  We do not plan to send 
those upstream until 2.6.18  -- This has nothing at all to do with 
Mauro's latest git-pull-request, or my email to Linus.

>At least, and thanks again for calming me down once, it is not about
>some white space only now.
>
I'm not sure what you mean.  Sure, we do have some drastic changes 
coming up for 2.6.18 ...  but this email is about bugfixes that HAVE in 
fact been thoroughly tested.

It sounds to me as if you may be getting the pending changesets in 
Mauro's git tree confused with current changes in our mercurial 
development repository.

Just take a look at v4l-dvb.git ...   (or at the diffstat earlier in 
this thread) ..  You will find that the drastic changes that you have 
mentioned aren't there yet.  Those do need some more testing before 
being sent upstream... I think they'll be ready in time for the 2.6.18 
merge window, but this is not the issue right now.

Thanks for your concern,

Michael Krufky
