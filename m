Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSGEFHp>; Fri, 5 Jul 2002 01:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSGEFHo>; Fri, 5 Jul 2002 01:07:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315415AbSGEFHn>;
	Fri, 5 Jul 2002 01:07:43 -0400
Date: Fri, 5 Jul 2002 01:10:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid kdev_t cleanups (part 1)
In-Reply-To: <15653.6720.628807.611023@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0207050101230.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jul 2002, Neil Brown wrote:

> On Friday July 5, viro@math.psu.edu wrote:
> > 	* ->error_handler() switched to struct block_device *.
> > 	* md_sync_acct() switched to struct block_device *.
> > 	* raid5 struct disk_info ->dev is gone - we use ->bdev everywhere.
> > 	* bunch of kdev_same() when we have corresponding struct block_device *
> > and can simply compare them is removed from drivers/md/*.c
> 
> I've actually got a whole bunch of md stuff pending that covers all
> this and more...

Eeek... So have I, actually (see subsequent patches).

> could you hold off a few days until I get it
> submitted so that I don't have to re-merge??

Damn.  I've just sent the last one raid-related one...

OK...  Mind if I do that merge?  Just send them to me, I'll do the merge
tonight and send them back for your approval ASAP.

