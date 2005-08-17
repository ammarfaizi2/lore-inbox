Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVHQK6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVHQK6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 06:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVHQK6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 06:58:11 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:65473 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750960AbVHQK6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 06:58:10 -0400
Message-ID: <43031A12.8020301@aitel.hist.no>
Date: Wed, 17 Aug 2005 13:05:54 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays
References: <42F89F79.1060103@aitel.hist.no>	 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>	 <43008C9C.60806@aitel.hist.no>	 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>	 <20050815221109.GA21279@aitel.hist.no>	 <21d7e99705081516182e97b8a1@mail.gmail.com>	 <21d7e99705081516241197164a@mail.gmail.com>	 <20050816165242.GA10024@aitel.hist.no>	 <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>	 <20050816211424.GA14367@aitel.hist.no> <21d7e99705081616504d28cca5@mail.gmail.com>
In-Reply-To: <21d7e99705081616504d28cca5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>>...
>>
>>Seems like it died trying to perform int10 initialization?
>>    
>>
>
>I'm still pointing towards that assign pci resources patch from Gregs
>tree that I mentioned earlier..
>  
>
git is completely new to me - is there a git-specific way to get this
patch, or should I download it the usual way from somewhere?

>the fact that disabling the DRM stops things from working is really
>bad, maybe the pci_enable_device in the DRM is setting up the devices,
>whereas  without it X tries and fails...
>
>  
>
That was strange, sure.  Could be a different bug too.

>>I can try running the radeon xserver only, as the vga console is on the matrox
>>card.
>>
>>    
>>
>
>I'm running low on ideas, I'm also having a hard time tracking what is
>actually happening,  the MGA bugs I've tracked are related to that
>assign pci resources patch, and I really can't see what is happening
>if the DRM isn't in the mix..
>
>If you build a working kernel (i.e. like 2.6.13 without DRM) does it
>hang similarly?
>
>  
>
2.6.13 isn't released, so I assume you meant some earlier kernel?
I'll see if I can get a drm-less kernel running.

Helge Hafting
