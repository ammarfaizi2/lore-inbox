Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbSKLVxH>; Tue, 12 Nov 2002 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSKLVwZ>; Tue, 12 Nov 2002 16:52:25 -0500
Received: from im2.mail.tds.net ([216.170.230.92]:24816 "EHLO im2.sec.tds.net")
	by vger.kernel.org with ESMTP id <S266970AbSKLVwR>;
	Tue, 12 Nov 2002 16:52:17 -0500
Date: Tue, 12 Nov 2002 16:57:43 -0500 (EST)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@cerberus.localhost
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
In-Reply-To: <20021112080417.GA11660@think.thunk.org>
Message-ID: <Pine.LNX.4.44.0211121656230.21234-100000@cerberus.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Nov 2002, Theodore Ts'o wrote:

> On Mon, Nov 11, 2002 at 08:49:22PM -0500, Alexander Viro wrote:
[snip]
> 
> Hi Al,
> 
> It's good that you're trying to clean up the devfs code, but...
> 
> How many people are actually using devfs these days?  I don't like it
> myself, and I've had to add a fair amount of hair to fsck's
> mount-by-label/uuid code to deal with interesting cases such as
> kernels where devfs is configured, but not actually mounted (it
> changes what /proc/partitions exports).  So I'm one of those who have
> never looked all that kindly on devfs, which shouldn't come as a
> surprise to most folks.
> 
> In any case, if there aren't all that many people using devfs, I can
> think of a really easy way in which we could simplify and clean up its
> API by slimming it down by 100%......
> 

Actually, a lot of people are. Gentoo, at least, uses it by default.

I think devfs is a good idea, as a user of it.

