Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVBXTEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVBXTEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVBXTEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:04:34 -0500
Received: from [195.23.16.24] ([195.23.16.24]:9895 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261820AbVBXTE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:04:27 -0500
Message-ID: <421E2528.8060305@grupopie.com>
Date: Thu, 24 Feb 2005 19:04:08 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chad N. Tindel" <chad@tindel.net>
Cc: Chris Friesen <cfriesen@nortel.com>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com>
In-Reply-To: <20050224183851.GA24359@calma.pair.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad N. Tindel wrote:
>>Low-latency userspace apps.  The audio guys, for instance, are trying to 
>>get latencies down to the 100us range.
>>
>>If random kernel threads can preempt userspace at any time, they wreak 
>>havoc with latency as seen by userspace.
> 
> 
> Come now.  There is no such thing as a random kernel thread.  Any General
> Purpose kernel needs the ability to do work that keeps the entire system from 
> grinding to a halt.  

FYI most kernel threads do background work, that doesn't have hard 
real-time constraints. Why should my audio recording session get 
interrupted (read: "sent to the trashcan") just because the swap daemon 
decided that it was a good time to write some pages out? Couldn't it 
have waited just a few more milliseconds?

You don't seem to realize that you have just arrived to this mailing 
list and missed years of discussions on kernel architecture.

If you keep a learning attitude, there is a chance for this discussion 
to go on. However, if you keep the "Come now, don't bullshit me, this is 
a broken architecture and you're just trying to cover up" attitude, 
you're just going to get discarded as a troll.

I personally like the linux way: "root has the ability to shoot himself 
in the foot if he wants to". This is my computer, damn it, I am the one 
who tells it what to do.

This is much, much better than the "users are stupid, we must protect 
them from themselves" kind of way that other OS'es use.

Just my 0.02 euros,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
