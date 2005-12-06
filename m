Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVLFKqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVLFKqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVLFKqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:46:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:51075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964947AbVLFKqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:46:19 -0500
X-Authenticated: #428038
Date: Tue, 6 Dec 2005 11:46:17 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206104617.GB10574@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <87hd9n708t.fsf@mid.deneb.enyo.de> <200512060110.jB61AMHF004027@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512060110.jB61AMHF004027@pincoya.inf.utfsm.cl>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Horst von Brand wrote:

> > You mentioned security issues in your initial post.  I think it would
> > help immensely if security bugs would be documented properly (affected
> > versions, configuration requirements, attack range, loss type etc.)
> > when the bug is fixed, by someone who is familiar with the code.
> > (Currently, this information is scraped together mostly by security
> > folks, sometimes after considerable time has passed.)  Having a
> > central repository with this kind of information would enable vendors
> > and not-quite-vendors (people who have their own set of kernels for
> > their machines) to address more vulnerabilties promptly, including
> > less critical ones.
> 
> I've fixed bugs which turned out to be security vulnerabilities. And I
> didn't know (or even care much) at the time. Finding out if some random bug
> has security implications, and exactly which ones/how much of a risk they
> pose is normally /much/ harder than to fix the bugs.  And rather pointless,
> after the fix is in.

I believe everyone who maintains a nontrivial piece of software has
experienced a situation where a bug fix addressed a bug that could
actually be exploited and that wasn't clear at the time.

Calling this "pointless" after the fix is in leaves people in danger
unaware, unless it happens on a branch where every user can be expected
to update because only tested fixes are merged. As this isn't the case
for the kernel, but everyone moves on at will, doesn't care if a
previous bug fix is exploitable and whatnot, the Linux kernel's security
is essentially nonexistent, and expecting downstream QA teams to handle
this is just ridiculous for many reasons already mentioned.

-- 
Matthias Andree
