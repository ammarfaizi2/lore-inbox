Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266107AbUFUGGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbUFUGGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 02:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUFUGGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 02:06:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:26503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266107AbUFUGGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 02:06:10 -0400
Date: Sun, 20 Jun 2004 23:04:35 -0700
From: Greg KH <greg@kroah.com>
To: Jeremy <jeremy.katz@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linus <torvalds@osdl.org>, linuxppc64-dev@lists.linuxppc.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040621060435.GA28384@kroah.com>
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5afee1040620125272ab9f06@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 03:52:33PM -0400, Jeremy wrote:
> > Agreed.  And the old viodasd reason was rejected exactly because it was
> > such a f***ing mess.
> 
> The argument could be made that sysfs is similarly a f***ing mess and
> that instead of solving problems, it creates more.

It does?  Have you brought this up to the sysfs / kobject / driver model
authors?  I think they would be open to any critiques of the current
code, especially if such critique contains patches.

> The mess of symlinks present there is a disaster and disgusting for
> anyone who wants to actually write clean probing code.

What do you mean by this.  Any examples?

> Also, things in sysfs aren't exactly stable enough to count on as a
> dependable interface, but that's something the kernel has never
> reliably exported to userspace.

Why isn't sysfs stable enough?  You can find any driver instantly.  And
any device bound to that driver in a stable and repeatable manner.

So, give me specific examples, or stop ranting for no reason.

greg k-h
