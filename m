Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVAMXd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVAMXd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVAMXb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:31:26 -0500
Received: from mail.dif.dk ([193.138.115.101]:13984 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261778AbVAMX1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:27:44 -0500
Date: Fri, 14 Jan 2005 00:30:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Dave Jones <davej@redhat.com>
Cc: Marek Habersack <grendel@caudium.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050113220652.GJ3555@redhat.com>
Message-ID: <Pine.LNX.4.61.0501140020470.2867@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
 <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain>
 <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net>
 <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain>
 <20050113210229.GG24970@beowulf.thanes.org> <20050113213002.GI3555@redhat.com>
 <20050113214814.GA9481@beowulf.thanes.org> <20050113220652.GJ3555@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Dave Jones wrote:

> On Thu, Jan 13, 2005 at 10:48:14PM +0100, Marek Habersack wrote:
>  
>  > > If admins don't install updates in a timely manner, there's
>  > > not a lot we can do about it.  For those that _do_ however,
>  > > we can make their lives a lot more stress free.
>  > Indeed, but what does have it to do with a closed disclosure list? 
> 
> For the N'th time, it gives vendors a chance to have packages
> ready at the time of disclosure.
> 
>  > With open
>  > disclosure list you provide a set of fixes right away, the admins take them
>  > and apply. With closed list you do the same, but with a delay (which gives
>  > an opportunity for a "race condition" with the bad guys, one could argue).
>  > So, what's the advantage of the delayed disclosure?
> 
> Not having to panic and rush out releases on day of disclosure.
> Not having users vulnerable whilst packages build/get QA/get pushed to mirrors.
> 
The users are still vulnerable during the time you are preparing your 
kernel packages.
Personally I'd very much prefer to know of the bug even before a fix is 
ready since that would allow me to protect my systems in alternative ways 
until the fixes are ready.   Depending on the nature of the bug I 
could perhaps tweak firewall rulesets temporarily, temporarily disable 
certain services, perhaps I could mount a few filesystems read-only for a 
few days, maybe rebuild my current vulnerable kernel with an option 
disabled as a workaround and live with less functionality until the fix is 
ready, maybe even take vulnerable systems offline until a fix is ready. 
Having the info that the bug exists and can be targeted in this or 
that way gives me a chance to respond and protect my systems while a 
proper fix is being developed.  I can't do that if I'm in the dark until 
vendors feel comfortable and ready to release packaged bug free kernels - 
and all the time I'm waiting some black hat idiot may have found the same 
bug and cracked my system.


-- 
Jesper Juhl

