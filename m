Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264499AbRFTRZT>; Wed, 20 Jun 2001 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbRFTRZJ>; Wed, 20 Jun 2001 13:25:09 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14351 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264499AbRFTRZC>; Wed, 20 Jun 2001 13:25:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Theodore Tso <tytso@valinux.com>, Tony Gale <gale@syntax.dera.gov.uk>
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
Date: Wed, 20 Jun 2001 19:27:57 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <0105311813431J.06233@starship> <993049198.3089.2.camel@syntax.dera.gov.uk> <20010620120213.B22993@think.thunk.org>
In-Reply-To: <20010620120213.B22993@think.thunk.org>
MIME-Version: 1.0
Message-Id: <01062019275709.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 18:02, Theodore Tso wrote:
> On Wed, Jun 20, 2001 at 03:59:58PM +0100, Tony Gale wrote:
> > The main problem I have with this is that e2fsck doesn't know how to
> > deal with it - at least I haven't found a version that will. This makes
> > it rather difficult to use, especially for your root fs.
>
> Getting e2fsck to deal with directory indexing is on my todo list at
> this point.
>
> Daniel, do you have any preliminary patches to start with, or do I
> need to start from scratch?

No, I haven't written any user space code for this at all, the only source is 
the patch itself.  The debug code might be helpful - show_buckets.  It's 
incomplete though, it only shows one level of the tree.  I need to do 
something about that.  I'll also spiff up my pseudocode and data structure 
documentation and forward it.

--
Daniel
