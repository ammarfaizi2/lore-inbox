Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWA2GRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWA2GRu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWA2GRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:17:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:22799 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750827AbWA2GRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:17:49 -0500
Date: Sun, 29 Jan 2006 07:17:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, davej@redhat.com,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
Message-ID: <20060129061722.GY7142@w.ods.org>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain> <20060128204531.4786aaea.rdunlap@xenotime.net> <Pine.LNX.4.63.0601282053170.7205@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601282053170.7205@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 09:02:16PM -0800, Chuck Wolber wrote:
> On Sat, 28 Jan 2006, Randy.Dunlap wrote:
> 
> > On Sat, 28 Jan 2006 20:30:25 -0800 (PST) Chuck Wolber wrote:
> > 
> > > On Fri, 27 Jan 2006, Greg KH wrote:
> > > 
> > > > This is the start of the stable review cycle for the 2.6.14.7 
> > > > release. There are 6 patches in this series, all will be posted as a 
> > > > response to this one.  If anyone has any issues with these being 
> > > > applied, please let us know.  If anyone is a maintainer of the 
> > > > proper subsystem, and wants to add a signed-off-by: line to the 
> > > > patch, please respond with it.
> > > 
> > > Please correct me if I'm wrong here, but aren't we supposed to stop 
> > > doing this for the 2.6.14 release now that 2.6.15 is out?
> > 
> > Some people wanted more -stable so the stable team agreed to do a little 
> > more.  Is it a problem?
> 
> 
> I don't know if there is a problem, but it goes against the concept of 
> "one-off" fixes that aren't maintained (aka the purpose of the -stable 
> team). This slope eventually leads us to backporting -stable fixes from 
> other -stable releases etc etc. 

The purpose of -stable is to provide stable kernels to 2.6 users. If time
was not a problem, it's possible that there would be even more versions
supported. The day you will install Linux on a server, you'll understand
why it's problematic for some people to upgrade to latest version to get
fixes. And when you get something that works, you hope to be able to use
it as an alternative to a simple upgrade when the later breaks on your
hardware.

> If there's one thing I've learned from watching guys like Alan Cox 
> maintain stable releases, it's that they're profoundly good at saying 
> "no". I'm not saying that's warranted here, I'm just trying to encourage 
> the dialog (I suspect that I've missed part of the conversation as I am 
> not currently subscribed to LKML).

It's not a matter of saying "yes" or "no", it's a matter of helping
users in getting something which works best on their hardware while
still being reliable and secure. Maintainers propose some solutions
for this, and can adapt to users' demands. I don't see anything wrong
with this.

> ..Chuck..

Willy

