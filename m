Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTBETyy>; Wed, 5 Feb 2003 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTBETyy>; Wed, 5 Feb 2003 14:54:54 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:16906 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264646AbTBETyw>; Wed, 5 Feb 2003 14:54:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Date: Wed, 5 Feb 2003 14:04:21 -0600
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random>
In-Reply-To: <20030205174021.GE19678@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302051404.21524.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 February 2003 11:40, Andrea Arcangeli wrote:
> I'd appreciate if you could check why bitkeeper thinks such function
> is nobh_truncate_page and not block_truncate_page as my GPL software
> pretends while it checkouts all the changesets from the bitkeeper
> servers.

Andrea,
The change from block_truncate_page to nobh_truncate_page was done in 
Changeset 1.879.43.1.  This was created on January 9th, but not merged 
into Linus' tree until Monday, so it is not in 2.5.59.  I think the 
date of the changeset preceding 2.5.59 is causing the confusion.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

