Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265131AbUFGXbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265131AbUFGXbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFGXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:31:48 -0400
Received: from world.rdmcorp.com ([204.225.180.10]:56651 "EHLO
	mailhost.rdmcorp.com") by vger.kernel.org with ESMTP
	id S265131AbUFGXbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:31:46 -0400
Date: Mon, 7 Jun 2004 19:28:17 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Sean Neakums <sneakums@zork.net>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how to configure/build a kernel in a separate directory?
In-Reply-To: <6uy8mz3vff.fsf@zork.zork.net>
Message-ID: <Pine.LNX.4.58.0406071926540.22541@localhost.localdomain>
References: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
 <6uy8mz3vff.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jun 2004, Sean Neakums wrote:

> "Robert P. J. Day" <rpjday@mindspring.com> writes:
> 
> >   is there an easy way to configure/build one or both of a 2.4 and 2.6 
> > kernel in a totally separate directory from the source directory itself?
> >
> >   i'd like to have a totally pristine ("make mrproper"ed) source tree,
> > write-protected, readable by all, so that several developers can 
> > independently configure and build their own kernels without stepping on 
> > each other.
> 
> This isn't really what you want, but you can use 'cp -rl' to build a
> hard-linked tree from the pristine read-only tree and build there.
> This will at least address the space issue.

i was reminded of the easy solution with the 2.6 kernel, so that's a 
relief.  sadly, it's the 2.4 case that's more important to me at the 
moment, and it looks like it's major symlink time.  oh well ... more 
incentive to move on up to 2.6.

thanks.

rday
