Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbUJ0LMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUJ0LMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUJ0LMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:12:15 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25472 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262375AbUJ0LLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:11:47 -0400
Message-ID: <417F8269.2070307@grupopie.com>
Date: Wed, 27 Oct 2004 12:11:37 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       penguinppc-team@lists.penguinppc.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video
 card BOOT?
References: <200410160841.08441.adaplas@hotpop.com> <417E9E3D.573.3C0CDE1A@localhost>
In-Reply-To: <417E9E3D.573.3C0CDE1A@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.11; VDF: 6.28.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:
> Paulo Marques <pmarques@grupopie.com> wrote:
> .....
>>If the same treatment is applied to ops2.c and prim_ops.c, I
>>believe it would be possible to have a functional emulator for
>>about 32kb of kernel code size, which seems pretty reasonable to
>>me and could solve a lot of problems. 
> 
> 
> Wow, that is great!

Thanks :)

> 
>>The decrease in source code size also helps maintenance, since
>>there is not so much repeated code has it was before. 
>>
>>Of course, these changes are optimizing the emulator for code
>>size, and not execution speed. I haven't done any benchmarks to
>>see if there is a noticeable difference in speed. 
> 
> 
> Did you get the latest code? I have been sick with the flu and I think I 
> forgot to send you the latest code to play with. We should get you set up 
> so you can merge your changes into our tree and then we can update the 
> one in the X.org tree as well (Egbert Eich usually does that from our 
> tree).

No, I didn't get the latest source (you did disapear for a while :) ).

I started to work on the old source because:

  A - I really wanted to know if this could be done and what kind of 
improvements could be expected, even if the actual changes were thrown 
away in the end

  B - you said that only small bug fixes were made since this version, 
so I probably could diff the source I started from against the latest 
and do the same fixes to my latest source.

One other thing, is there a simple way to test the emulator? I've been 
careful with the changes I did not to change the resulting behaviour of 
the emulator, but I can not _absolutely_ sure that I didn't break 
anything. It would be very good to try the emulator in a controlled 
environment.

Anyway, I think I'll have some more time tonight, so probably tomorrow 
I'll have more information about the final code size.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
