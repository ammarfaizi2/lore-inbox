Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVLDWs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVLDWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVLDWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:48:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:18623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932375AbVLDWs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:48:28 -0500
Date: Sun, 4 Dec 2005 14:39:31 -0800
From: Greg KH <greg@kroah.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204223931.GA8914@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051204170049.GA4179@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204170049.GA4179@unthought.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 06:00:49PM +0100, Jakob Oestergaard wrote:
> 
> If the kernel was stable (reliability wise - as in "not crashing") then
> you'd be perfectly right.

But isn't it? :)

> In the real world, however, admins currently need to pick out specific
> versions of the kernel for specific workloads (try running a large
> fileserver on anything but 2.6.11.11 for example - any earlier or later
> kernel will barf reliably.

Have you filed a but at bugzilla.kernel.org about this?  If not, how do
you expect it to get fixed?

> For web serving it's another kernel that's golden, I forgot which).

That sounds very strange, the same kernel version should work just as
well for all workloads.  If not, it's a bug and should be fixed.

> There are very very good reasons for offering a 'stable series' in plain
> source-tree form - lots of admins of real-world systems need this.

But it sounds like you will want different stable series depending on
what kind of server you are running.  And that will be even more work...

thanks,

greg k-h
