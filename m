Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVCOUfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVCOUfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVCOUeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:34:46 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55705 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261706AbVCOUdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:33:15 -0500
Message-ID: <423747BC.2080703@tmr.com>
Date: Tue, 15 Mar 2005 15:38:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
References: <4231E75A.4090203@tmr.com><4231E75A.4090203@tmr.com> <20050311190825.GW3120@waste.org>
In-Reply-To: <20050311190825.GW3120@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> In your world, do you want to do:
> 
> cp -rl linux-2.6.11 linux-2.6.11.5
> cd linux-2.6.11.5
> bzcat ../Patches/patch-2.6.11.1.bz2 | patch -p1
> bzcat ../Patches/patch-2.6.11.2.bz2 | patch -p1
> bzcat ../Patches/patch-2.6.11.3.bz2 | patch -p1
> bzcat ../Patches/patch-2.6.11.4.bz2 | patch -p1
> bzcat ../Patches/patch-2.6.11.5.bz2 | patch -p1
> 
> I suspect you might find that tedious, especially if only the last one
> addressed a bug that affected you.

Being lazy, I would do
   bzcat ../Patches/patch-2.6.11.*.bz | patch -p1
(or similar). But as I posted long ago when this discussion started it 
is desirable to have both.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
