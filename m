Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTKDIsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 03:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTKDIsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 03:48:42 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:36317 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S263997AbTKDIsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 03:48:40 -0500
Subject: Re: allocating netlink families? (was: re: Announce: NetKeeper
	Firewall For Linux)
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: fleury@cs.auc.dk
In-Reply-To: <3FA6F628.70305@ixiacom.com>
References: <3FA6F628.70305@ixiacom.com>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1067935673.29545.1.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 09:47:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-04 at 01:43, Dan Kegel wrote:
> Emmanuel Fleury wrote:
>  >   http://www.cs.auc.dk/~fleury/netkeeper/
> 
> Hey, that seems to be a nice example of how to write
> a new netlink family.  Thanks!

:)

> I see you're using NETLINK_USERSOCK.  Netlink families
> appear to be a precious commodity (netlink_dev.c, at
> least, will break if you raise MAX_LINKS above 32).
> 
> Has there been any discussion of how one should pick
> netlink family numbers for new stuff like netkeeper?

I think netlink is perfect as it is for now. 
Our scheme just demonstrate how flexible is this code.

Before being added "permanently" (I don't like this word) we should get
out with something better than an alpha release. :)

But, even if the process is long, we are still working on it. 
And hopefully one day it will be possible to try Netekeeper easily
on your own network (I have to admit now that the user-space tools are
difficult to get to work, even if I trust a lot the kernel-space code).

> Sure, everyone could use NETLINK_USERSOCK, but
> that means only one new netlink module could be resident at a time...

Yes, this is true, but it doesn't matter so much for experimental things
(in my humble opinion).

Regards
-- 
Emmanuel

But the important thing is persistence.
  -- Calvin trying to juggle eggs (Bill Waterson)

