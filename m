Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUGYSzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUGYSzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 14:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUGYSzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 14:55:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:28090 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264270AbUGYSzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 14:55:42 -0400
Date: Sun, 25 Jul 2004 20:53:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Tim Wright <timw@splhi.com>, Adrian Bunk <bunk@fs.tum.de>,
       Paul Jackson <pj@sgi.com>, akpm@osdl.org, corbet@lwn.net,
       linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
In-Reply-To: <200407251459.46952.jk-lkml@sci.fi>
Message-ID: <Pine.LNX.4.60.0407252032420.13666@jjulnx.backbone.dif.dk>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040722232540.GH19329@fs.tum.de>
 <1090549329.6113.21.camel@kryten.internal.splhi.com> <200407251459.46952.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004, Jan Knutar wrote:

>> That is their choice, but there's no particular need to run a kernel.org
>> kernel. Unless you're messing around with the kernel or have a hot
>> requirement for some new feature, why would running a stable kernel from
>> e.g. Debian not suffice? Debian is free and freely available, and it's
>> not the only distribution that is that way.
>
> In the past, my experience, shared by many users, I'm sure, has been
> that distribution kernels generally give you worse performance (IME RH)
> and less stability (IME Fedora).
>

I have to agree with you here. My experience is that the vendor kernels 
are usually build to fit a wide variety of systems and include support for 
a huge amount of features since there's always some of their customers 
that need feature X or feature Y, so they include all of them, which leads 
to a kernel that runs slower than it has to and has a bigger potential for 
problems (more features included == more stuff that can blow up in your 
face).

>
[snip]
> Thus, we have a whole generation of users out there who grew up
> with the idea that the distribution kernel is just some bloated,
> bug-ridden and mostly incompatible monstrosity that is only barely
> good for bootstrapping kernel.org kernel before starting to try
> compile the drivers for their hardware.
>
Indeed. That's my personal attitude to vendor kernels, and I know it's 
shared by most of my Linux using friends.
First thing you do after getting your distribution of choice installed is 
to go to kernel.org, grab the latest stable kernel, build it with the 
features you need and then leave the vendor kernel far behind for good. 
Personally this is what I do for both my personal systems and my servers 
at work - and that's pretty common, and since the latest stable kernel.org 
kernel tends to actually /be/ stable that approach has worked well for 
years.

Also not all vendors keep up with security fixes equally well, so it's a 
common (at least in my experience) attitude that if you want to keep 
up-to-date security wise you should just keep up with the kernel.org 
kernels and you are resonably safe.

Also, it is usually a pretty safe bet that if you need to use third party 
modules, you are very good off with a kernel.org kernel as that tends to 
be the reference kernel that stuff gets tested against (personal 
experience, I have nothing concrete to back that up with).

If the stable kernel.org kernel stops being stable and reliable a lot of 
users will be badly disappointed and will be forced to either stay with 
old insecure kernels or be forced to use vendor kernels with all the bloat 
that implies. That would be a sad state of afairs in my oppinion.

I guess the perfect situation would be if the kernel.org kernel would be 
stable enough and feature rich enough that the vendors didn't /need/ to 
supply anything else than the stock kernel from kernel.org - how to get to 
that point I don't know though.

just my 0.02euro


--
Jesper Juhl <juhl-lkml@dif.dk>

