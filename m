Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbULPR0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbULPR0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbULPR0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:26:13 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:24448 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261767AbULPR0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:26:04 -0500
Message-ID: <41C1C579.7040106@tmr.com>
Date: Thu, 16 Dec 2004 12:27:21 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix Dorner <felix_do@web.de>
CC: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: Re: internal card reader support
References: <41B74174.3080908@web.de>
In-Reply-To: <41B74174.3080908@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Dorner wrote:
> Hi,
> 
> 
> My notebook (hp nx9105) has an integrated 5in1 card-reader. I would 
> really like to use this with linux.
> Since I do not think it is supported yet, I d like to know if it might 
> be possible to write a module or so for this.
> I am just an average C programmer, but always wanted to dive into kernel 
> developement. My knowledge on computer architecture is also no more than 
> basic, so this might be something to really learn a lot...
> So I start at zero knowledge now. First of course I need to find out if  
> what I want to do is possible at all.
> This means now to identify the hardware inside and see if I can get 
> documents for that.
> 
> First I just start with:
> 
> #lspci
> [...]
> 0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 
> 01)
> 0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 
> 01)
> 0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 
> (rev 01)
> [...]
> 
> This is all that I have. Now I am already confused. My box has one 
> PCMCIA slot. Which is now the PCMCIA and which is the CardReader? What 
> about the third device? Might this be the integrated infrared controller?
> 
> Can you give me any hints/tips where to start best, what to read first?
> 
> I know this seems to be very difficult, but I have quite some free time 
> that I don't want to spend playing bzflag all night long, so I think 
> this is a great way to learn something.

The first question is if this shows up as USB (therefore SCSI), or IDE. 
I had an old desktop with PCMCIA and it all used the IDE driver. I'm 
interested, I'd love to use the slot on my Acer!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
