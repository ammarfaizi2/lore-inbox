Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVBYVm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVBYVm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVBYVm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:42:29 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:734 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261828AbVBYVm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:42:27 -0500
Message-ID: <421F9CE3.7010500@tmr.com>
Date: Fri, 25 Feb 2005 16:47:15 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Hey, I hoped -rc4 was the last one, but we had some laptop resource
> conflicts, various ppc TLB flush issues, some possible stack overflows in
> networking and a number of other details warranting a quick -rc5 before
> the final 2.6.11.
> 
> This time it's really supposed to be a quickie, so people who can, please 
> check it out, and we'll make the real 2.6.11 asap.
> 
> Mostly pretty small changes (the largest is a new SATA driver that crept
> in, our bad). But worth another quick round.

Three bugs down, one to go...

- backlight poweroff from screensaver: WORKING
- power off on shutdown: RELIABLE
- detection of the DVD drive without a disk in it at boot: WORKING
- sound: hasn't worked since FC1...

ASUS 1681 Pentium-M, 512MB, 80GB, 1400x1050 screen

FC1 worked, clean install FC2 had display issues, upgrade to FC3 doesn't 
use full screen size and sound is totally NFG. I'm going to drop back to 
oss over the weekend and see if that helps.

If anyone cares, the relevant lspci, dmesg, lsmod, etc, etc, are at
   //216.238.38.194/nosound
and it will be up unless some development breaks it. I have posted this 
elsewhere, could see attaching all the cruft to a message for the whole 
list.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
