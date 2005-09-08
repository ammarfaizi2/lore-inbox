Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVIHTgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVIHTgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVIHTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:36:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964962AbVIHTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:36:13 -0400
Date: Thu, 8 Sep 2005 12:35:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       davem@redhat.com
Subject: Re: Serial maintainership
Message-Id: <20050908123525.6bc0cb26.akpm@osdl.org>
In-Reply-To: <20050908172537.F5661@flint.arm.linux.org.uk>
References: <20050908165256.D5661@flint.arm.linux.org.uk>
	<1126197523.19834.49.camel@localhost.localdomain>
	<20050908172537.F5661@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Thu, Sep 08, 2005 at 05:38:43PM +0100, Alan Cox wrote:
> > On Iau, 2005-09-08 at 16:52 +0100, Russell King wrote:
> > > I notice DaveM's taken over serial maintainership.  Please arrange for
> > > serial patches to be sent to davem in future, thanks.  (All ARM serial
> > > drivers are broken as of Tuesday.)
> > > 
> > > I might take a different view if I at least had a curtious CC: of the
> > > patch, which I had already asked akpm to reject.
> > > 
> > > Thanks.  That's another subsystem I don't have to care about anymore.
> > 
> > Please remember to send Linus a patch updating MAINTAINERS if so.
> 
> Well, it appears that we're fast approaching meltdown in kernel
> land - patches are being applied despite maintainers objection,
> maintainers are not being copied with changes in their area, etc.

Sometimes.  They're mistakes.

> I might mind less with the occasional slip up if it was occasional,
> but it doesn't appear to be anymore - maybe not from my perspective.

The number of times I've been made aware of it happening is quite occasional.

> This morning Andi Kleen stated:
> 
>  "normally he (akpm) asks you before finally sending them off -
>   then you can complain again"
> 
> I don't appear to be asked by akpm

Maintainer is (at least) cc'ed when the patch goes into -mm and when it
goes over to Linus.  Post-facto complaining is appreciated, so we can fix
the kernel and so I can tweak the process or the brain.

> - patches from -mm are sent
> to Linus CC'd me, and that occurs during the night.  Come the
> morning, they're in Linus tree so unless one is awake reading
> email 24 hours a day, it's impossible to "complain again".

It shouldn't be necessary to complain more than once.  Sometimes I'll hang
on to a complained-about patch a) to remember that something needs to
happen and b) because an update is expected.  Once or twice I've
accidentally submitted such patches.

This particular patch ([SERIAL]: Avoid 'statement with no effect'
warnings.) didn't ever go into -mm.
