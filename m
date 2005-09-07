Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVIGQe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVIGQe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIGQe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:34:29 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34825 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750712AbVIGQe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:34:28 -0400
Message-ID: <431F1778.5050200@tmr.com>
Date: Wed, 07 Sep 2005 12:38:16 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Adrian Bunk <bunk@stusta.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua> <200509041144.13145.paul@misner.org> <84144f02050904100721d3844d@mail.gmail.com> <6880bed305090410127f82a59f@mail.gmail.com> <20050904193350.GA3741@stusta.de> <6880bed305090413132c37fed3@mail.gmail.com> <20050904203725.GB4715@redhat.com>
In-Reply-To: <20050904203725.GB4715@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Sep 04, 2005 at 10:13:10PM +0200, Bas Westerbaan wrote:
>  > > > Though 4K stacks are used a lot, they probably aren't used on all
>  > > > configurations yet. Other situations may arise where 8K stacks may be
>  > > > preferred. It is too early to kill 8K stacks imho.
>  > > 
>  > > Please name situations where 8K stacks may be preferred that do not
>  > > involve binary-only modules.
>  > 
>  > I meant that there could be situations, which have not yet been found,
> 
> And the boogeyman might really exist too.
> This is just hypotetical hand-waving.
> 
>  > where it could be preferred to use 8K stacks instead of 4K. When you
>  > switch from having 8K stacks as default to 4K stacks without
>  > possibility for 8K stacks you'd possibly encounter these yet to be
>  > found situations.
> 
> Fedora kernels have been built with 4K stacks for a long time.
> (Since even before the option went upstream). The only things that
> have been reported to have problems with 4KB stacks are..
> 
> - NDISwrapper / driverloader.
>   (Shock, horror - no-one cares).

Actually, people who want to run Linux on laptops instead of MS care a 
whole bunch! And not everyone has a committment from their employer to 
provide Linux compatible hardware, or the personal funds to spend extra 
to buy their own instead of getting a bargain laptop which may not be 
fully supported. 8KSTACKS is in and working, you are proposing to break 
Linux on a number of machines just to satisfy some personal distaste for 
the code, not because there is neat new code which fails to work with 8K 
stacks.

You must have something more useful to work on, which would ADD value to 
the kernel instead of breaking existing installations. Ripping out petty 
stuff which works is a waste of your time and talent, please find 
something better to do. Perhaps devise a way for programs like 
ndiswrapper to provide their own stack, for instance.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
