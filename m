Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273143AbRIJCP3>; Sun, 9 Sep 2001 22:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273150AbRIJCPI>; Sun, 9 Sep 2001 22:15:08 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:5892 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273143AbRIJCPB>; Sun, 9 Sep 2001 22:15:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 04:22:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org> <20010910035519.B11329@athlon.random> <20010910020752Z16066-26184+197@humbolt.nl.linux.org>
In-Reply-To: <20010910020752Z16066-26184+197@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910021513Z16066-26183+696@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 04:15 am, Daniel Phillips wrote:
> On September 10, 2001 03:55 am, Andrea Arcangeli wrote:
> > getblk should unconditionally alloc a new bh entity and only care to map
> > it to the right cache backing store with a pagecache hash lookup.
> 
> To feel anything like the original the new getblk has to be idempotent: 
> subsequent calls return the same block.

Err, buffer_head

--
Daniel
