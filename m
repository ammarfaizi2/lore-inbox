Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271755AbTHDO7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271758AbTHDO7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:59:42 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:20467 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S271755AbTHDO7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:59:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Subject: Re: TOE brain dump
Date: Mon, 4 Aug 2003 09:56:03 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <gq0f.8bj.9@gated-at.bofh.it> <gNpS.2YJ.9@gated-at.bofh.it> <3F2E6A86.3060402@softhome.net>
In-Reply-To: <3F2E6A86.3060402@softhome.net>
MIME-Version: 1.0
Message-Id: <03080409560301.03650@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 09:15, Ihar 'Philips' Filipau wrote:
> Jesse Pollard wrote:
> >>3k of code.
> >>not 650k of bzip.
> >
> > And it handles ipfilter?
> > and LSM security hooks?
> > how about IPSec?
> > and IPv6?
> >
> > I don't think so.
>
>    Answer is "No".
>
>    I'm running expensive workstation - and I'm _NOT_ using
> LSM/IPSec/IPv6. I do not care what I _*can*_ do - I care about what I
> _*need*_ to do.
>    Point is here that 3k of code is all what we need. Not 'what every
> one does need', not Linux kernel.

I'm on a workstation right now that needs IPv6 sometime in the next few 
months. There have been several instances where IPSec would have resolved
internal problems (it's not easily available for Solaris yet.. soon).

So why should I buy another interface every time I need to change networks?

And who said it was a workstation target? If you are going to offload TCP/IP
in a TOE, it should be where it might be useful - large (and saturated) 
compute servers, file servers. Not workstations. High bandwidth workstation
requirements are rare. And large servers will require IPSec eventually 
(personally, I think it should be required already). And if the server
requires IPSec, then the workstation will too.

So you have programmed your way into a small market. And a likely shrinking 
one at that.
 
>
> P.S.
>    printk() is absolutely renundant since there is no display at all ;-)
>    And can you imagine Linux without printk, bug_on & panic?-)))

So? It's called "embeded Linux". No MM, no printk (for production anyway).
Display not required.
