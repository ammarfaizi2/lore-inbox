Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWEBPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWEBPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWEBPA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:00:57 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:56394 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964855AbWEBPA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:00:56 -0400
Message-ID: <44513CDB.4050104@tmr.com>
Date: Thu, 27 Apr 2006 17:51:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16.11
References: <20060424203358.GA17597@kroah.com>
In-Reply-To: <20060424203358.GA17597@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> We (the -stable team) are announcing the release of the 2.6.16.11 kernel
> (because just one -stable kernel a day is obviously not enough...)
> 
> The diffstat and short summary of the fixes are below.
> 
> I'll also be replying to this message with a copy of the patch between
> 2.6.16.10 and 2.6.16.11, as it is small enough to do so.
> 
> The updated 2.6.16.y git tree can be found at:
>  	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> and can be browsed at the normal kernel.org git web browser:
> 	www.kernel.org/git/
> 
> thanks,
> 
> greg k-h

Looks good, I dropped it on an ASUS laptop running FC4 and everything 
works, including the selinux stuff. However, I did note these things:
1 - sounds has stopped working on the FC4 kernel (again) 2.6.16.11 ok
2 - at boot, the 2.6.16.11 kernel stops after the "storage" text in the 
"initializing" line, and hangs long enough for me to say "Oh .... it 
hung" before continuing.
3 - ipw2200 wireless continues to work flawlessly. I mention this 
because there was a time when every patch was an adventure.

Thanks for the patches.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

