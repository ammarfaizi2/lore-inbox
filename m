Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVFFUAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVFFUAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVFFT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:58:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39113 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261656AbVFFTyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:54:52 -0400
Message-ID: <42A4AA01.90905@pobox.com>
Date: Mon, 06 Jun 2005 15:54:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz>
In-Reply-To: <20050606192654.GA3155@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>It's being uploaded right now, the git tree is already up-to-date, and by 
>>the time this hits the mailing list the mirroring of the tar-ball will 
>>hopefully be done too.
>>
>>And since Jeff wrote me a shortlog script for git, the easist way to tell
>>what's new since -rc5 is to just do the shortlog and diffstat output. 
>>Network drivers, USB and CPU-freq stand out.
>>
>>And the good news is that people do seem to have taken my rumblings about 
>>calming down for 2.6.12 seriously. Let's hope that pans out, and I can 
>>release that one asap.. But give this a good beating first, and holler 
>>(again, if you must) about any issues you have,
> 
> 
> 
>>Pavel Machek:
>>  fix jumpy mouse cursor on console
> 
> 
> This one was from Dmitry, and git logs know that:
> 
> author Pavel Machek <pavel@suse.cz> Fri, 27 May 2005 12:53:03 -0700
> committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 28 May 2005 11:14:01 -0700
> 
>     [PATCH] fix jumpy mouse cursor on console
> 
>     Do not send empty events to gpm.  (Keyboards are assumed to have scroll
>     wheel these days, that makes them part-mouse.  That means typing on
>     keyboard generates empty mouse events).
> 
>     From: Dmitry Torokhov <dtor_core@ameritech.net>
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> ...perhaps shortlog script needs some updating?


In git-whatchanged, you are listed as the author:


> diff-tree c1e4c8d3ee3300f363a52fd4cf3d90fdf5098f5a (from 8bd7f125e2f217c8aa3dff0
> Author: Pavel Machek <pavel@suse.cz>
> Date:   Fri May 27 12:53:03 2005 -0700
>     
>     [PATCH] fix jumpy mouse cursor on console
>     
>     Do not send empty events to gpm.  (Keyboards are assumed to have scroll
>     wheel these days, that makes them part-mouse.  That means typing on
>     keyboard generates empty mouse events).
>     
>     From: Dmitry Torokhov <dtor_core@ameritech.net>
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

'^Author: ' is what git-shortlog looks at.

Regards,

	Jeff



