Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVCCI70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVCCI70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVCCI70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:59:26 -0500
Received: from web21324.mail.yahoo.com ([216.136.175.210]:46752 "HELO
	web21324.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261660AbVCCI7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:59:19 -0500
Message-ID: <20050303085918.92037.qmail@web21324.mail.yahoo.com>
Date: Thu, 3 Mar 2005 00:59:18 -0800 (PST)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: RFD: Kernel release numbering
To: Willy Tarreau <willy@w.ods.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050302231231.GA30106@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Willy Tarreau <willy@w.ods.org> wrote:

> Hi Linus,
> 
> For a long time, I've been hoping/asking for a more frequent
> stable/unstable cycle, so clearly you can count my vote on this one 
> (eventhough it might count for close to zero). This is a very good step

> towards a better stability IMHO.
> 
> However, I have a comment :
> 
> >  - 2.6.<odd>: still a stable kernel, but accept bigger changes
> >    leading up to it (timeframe: a month or two).
> >  - 2.<odd>.x: aim for big changes that may destabilize the kernel for
> >    several releases (timeframe: a year or two)
> >  - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and
> >    rewrote the kernel to be a microkernel using a special
> >    message-passing version  of Visual Basic. (timeframe: "we expect 
> >    that he will be released from the mental institution in a decade
or
> >    two").
> 
> I don't agree with you on this last one (not the fact that you don't
> want an mk+mp+vb combination :-)). The VERSION number (in the makefile
> meaning of the term) only gets updated every 10 years or so. So it does

> not need to jump. PATCHLEVEL increments are rare enough to justify lots

> of breaking.  I certainly can imagine people laughing at your OS when 
> you jump from v2.6.X to v4.0.X, it will have a smell of slowaris 
> (remember 2.6 - 2.7 - 7 - 8 that confused everyone ?). On the other 
> side, the openbsd numbering scheme is far simpler to understand, and I 
> sincerely think that we should enter 3.0 after 2.8.

I hate to point out the obvious to someone of longer standing, but
according to the current system, since we increment integrally, 2.10.0
would be the successor release to the 2.9.X dev series, unless you know
something about a severe and profound internals shakeup scheduled for 2.9
that we don't.  :)

OT, 3.0.0 is an even-numbered release, therefore stable.  So what do you
call the odd-numbered unstable series that produces it?  ;)

> As a side note, I've
> always wondered why we would not swap odds and evens, so that we can 
> keep the same major number between devel and release (eg: devel 2.8, 
> release 2.9 ; not devel 2.9, release 3.0). Anyway, people have got used

> to stay away from the '.0' releases of any product on the planet.
> 
> Regards
> Willy
> 

Matt

Yes, I have too much free time.
