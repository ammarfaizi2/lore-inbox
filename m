Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269995AbRHJTuX>; Fri, 10 Aug 2001 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269996AbRHJTuM>; Fri, 10 Aug 2001 15:50:12 -0400
Received: from mail.valinux.com ([198.186.202.175]:776 "EHLO mail.valinux.com")
	by vger.kernel.org with ESMTP id <S269995AbRHJTuC>;
	Fri, 10 Aug 2001 15:50:02 -0400
Message-ID: <3B743AAF.8050100@valinux.com>
Date: Fri, 10 Aug 2001 13:49:03 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: scott1021@mediaone.net
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac10
In-Reply-To: <Pine.LNX.4.33.0108101423220.1544-100000@tweety.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott M. Hoffman wrote:

> On Fri, 10 Aug 2001 at 14:08 +0100 Alan Cox wrote:
> 
>>>   Linus' pre8 patch fixes it, but then I was unable to get the ext3 patch
>> 
>> Umm Linus tree only has DRM 4.1 ?
>> 
> 
> Well, I originally did say that I was confused. I understand that some
> would like to have the 4.0 as well as the 4.1 option, but with having both
> options, I had wondered if the 4.0 code was interferring with the 4.1 code
> and causing my segfaults.

Its either or here.  You can have the 4.1 kernel modules OR the 4.0 
kernel modules.  Not both.

> 
>  Anyway, with ac11 I still get segfaults trying to glxinfo or glxgears.
> 
> 
> Scott Hoffman

What version of XFree are you running?
What video card?
Which version of the drm did you pick (new or old)?
Has the drm worked in this configuration before?
Does the Xserver say that the DRM is enabled?
Could you post the Xserver log?
Could you post a gdb backtrace of the segfault?
Have you run these programs with the environment variable 
'LIBGL_DEBUG=verbose'?  Is it finding the correct 3d client side driver?

Its kind hard to help someone when they just say things are broken.  I 
need more information to help you.

-Jeff

