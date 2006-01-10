Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWAJUXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWAJUXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWAJUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:23:13 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:30951 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S932558AbWAJUXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:23:13 -0500
Message-ID: <43C417A5.6070104@mnsu.edu>
Date: Tue, 10 Jan 2006 14:23:01 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: 64-bit vs 32-bit userspace/kernel benchmark? Was: Athlon 64 X2 cpuinfo
 oddities
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>	 <p73r77gx36u.fsf@verdi.suse.de>	 <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>	 <200601100336.31677.ak@suse.de> <9a8748490601100129h2ce343f5kc9bc22885f01831a@mail.gmail.com>
In-Reply-To: <9a8748490601100129h2ce343f5kc9bc22885f01831a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>On 1/10/06, Andi Kleen <ak@suse.de> wrote:
>  
>
>>On Tuesday 10 January 2006 03:12, Jesper Juhl wrote:
>>    
>>
...

>>Ah - how legacy.
>>
>>    
>>
>Yeah, but since my distro of choice is 32bit only and I don't much
>feel like porting it myself or using an unofficial port (slamd64) I'm
>sticking with a 32bit userspace. And as long as userspace is pure
>32bit there doesn't seem to be much point in building a 64bit kernel.
>And I only have 2GB of RAM, so I don't have a use for the larger 64bit
>address space.
>I also don't run any apps that do a lot of math on >32bit numbers, so
>there's not much gain there either.
>I guess I would bennefit from the extra GPR's, but then I would at the
>same time loose a bit by all pointers being 64bit - both lose some
>disk space due to larger binaries and I'd have increased memory use
>and less efficient L1/L2 cache use.
>
>I don't think there would actually be much gain for me in switching to
>a 64bit kernel with a 64bit userspace atm.
>But if I'm wrong I'd of course love to hear about it :)
>
>  
>

Has anyone done any actual benchmark tests that show 64-bit vs 32-bit 
environments/distributions with Athlon64 processors.  If so, I love to 
see the results.  I too elected to stick with 32-bit, using the same 
reasoning/guessing above.

-- 
Jeffrey Hundstad

