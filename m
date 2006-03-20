Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbWCTWwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbWCTWwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWCTWwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38078 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030570AbWCTWwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:52:36 -0500
X-Authenticated: #428038
Date: Mon, 20 Mar 2006 23:52:32 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Garzik <jeff@garzik.org>,
       joe.korty@ccur.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
Message-ID: <20060320225232.GA30981@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Jeff Garzik <jeff@garzik.org>, joe.korty@ccur.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060320171905.GA4228@tsunami.ccur.com> <441EFCB0.6020007@garzik.org> <Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr> <Pine.LNX.4.64.0603201132070.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603201132070.3622@g5.osdl.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Linus Torvalds wrote:

> 
> 
> On Mon, 20 Mar 2006, Jan Engelhardt wrote:
> > >
> > > strace should be using sanitized versions of the kernel headers, not directly
> > > including them verbatim...
> > >
> > Now, would not it be good for everyone if the in-kernel headers get
> > every bit of sanitation?
> 
> Yes, we should strive for fairly sanitized headers. That said, Jeff is 
> also right - people really generally shouldn't use the kernel headers 
> directly.

It appears this message hasn't spread wide enough yet. When reporting an
inotify-related build failure, I heard back from the GNOMES I shouldn't
be using outdated glibc headers but kernel headers instead... apparently
there's more need for discussion.

(Not that I'd find gamin particularly sensible, since it's undocumented,
and attracted WAY too much attention because of its flaws like SIGSEGV
in applications, 100% CPU loops and other shortcomings not only in Linux
environments, but also on FreeBSD.)

-- 
Matthias Andree
