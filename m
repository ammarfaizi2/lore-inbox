Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUBAIY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 03:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUBAIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 03:24:29 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:43487 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S265232AbUBAIY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 03:24:27 -0500
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
From: Alan <alan@clueserver.org>
To: Jens Axboe <axboe@suse.de>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org, Mans Matulewicz <cybermans@xs4all.nl>
In-Reply-To: <20040131184923.GD11683@suse.de>
References: <1075511134.5412.59.camel@localhost>
	 <20040131093438.GS11683@suse.de> <401BF122.2090709@blue-labs.org>
	 <20040131184923.GD11683@suse.de>
Content-Type: text/plain
Message-Id: <1075623865.26031.9.camel@zontar.clueserver.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 01 Feb 2004 00:24:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-31 at 10:49, Jens Axboe wrote:
> On Sat, Jan 31 2004, David Ford wrote:
> > I don't have an RW, but when my cdrom fixates, it stalls everything 
> > while it's fixating.  I have an nForce chipset.  (2.6.x)
> 
> Does "everything" mean everything on that ide channel? If so, then
> that's a hardware limitation.

I have seen the problem as well.

It is not just processes using the IDE.  Everything will pause for a
second or two. (Which causes grief with streaming audio running at the
same time.)

Even more annoying is that it does not always occur. I have not tried
tracking down where the kernel is getting hung up at that moment since
it has been fairly intermittent for me.

-- 
"Push that big, big granite sphere way up there from way down here!
Gasp and sweat and pant and wheeze! Uh-oh! Feel momentum cease!
Watch it tumble down and then roll the boulder up again!"
    - The story of Sisyphus by Dr. Zeus in Frazz 12/18/2003

