Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWA2E4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWA2E4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 23:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWA2E4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 23:56:43 -0500
Received: from xenotime.net ([66.160.160.81]:3200 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750824AbWA2E4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 23:56:43 -0500
Date: Sat, 28 Jan 2006 20:57:01 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: jmforbes@linuxtx.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       davej@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
Message-Id: <20060128205701.5b84922e.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.63.0601282048380.7205@localhost.localdomain>
References: <20060128021749.GA10362@kroah.com>
	<Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
	<20060129044307.GA23553@linuxtx.org>
	<Pine.LNX.4.63.0601282048380.7205@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006 20:52:46 -0800 (PST) Chuck Wolber wrote:

> On Sat, 28 Jan 2006, Justin M. Forbes wrote:
> 
> > On Sat, Jan 28, 2006 at 08:30:25PM -0800, Chuck Wolber wrote:
> > > 
> > > Please correct me if I'm wrong here, but aren't we supposed to stop doing 
> > > this for the 2.6.14 release now that 2.6.15 is out?
> >
> > I don't see a problems with doing additional stable releases for any 
> > kernel, I just wouldn't commit to supporting any specific number of 
> > releases.  Basically if people send enough patches to warrant a 
> > review/release there is obviously some interest.  What is the harm?
> 
> The harm is that stable release patches will eventually start being 
> maintained and we'll have to add another stable release "dot" to the end 
> of the growing width of the release version moniker. This stable branch 
> was meant only for "one-off" fixes to a stable release, not for adding 
> fixes upon fixes upon fixes that eventually turn into features that have 
> to be maintained. A new stable release means we change our focus to it and 
> ignore the old stable release.

It's a 6-month sliding window for stable releases IIRC.
Maybe <stable@kernel.org> can add something like that to
Documentation/stable_kernel_rules.txt>.

---
~Randy
