Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSJOE60>; Tue, 15 Oct 2002 00:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbSJOE60>; Tue, 15 Oct 2002 00:58:26 -0400
Received: from thunk.org ([140.239.227.29]:10701 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262357AbSJOE6Z>;
	Tue, 15 Oct 2002 00:58:25 -0400
Date: Tue, 15 Oct 2002 01:04:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015050409.GA29930@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <3DAB9DA5.42008138@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB9DA5.42008138@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 09:46:29PM -0700, Andrew Morton wrote:
> tytso@mit.edu wrote:
> > 
> >...
> > This first patch creates a generic interface for registering caches with
> > the VM subsystem so that they can react appropriately to memory
> > pressure.
> > 
> 
> Seems our patches passed in the night - Linus already has one of
> those APIs.
> 
> I've converted xattr to use the set_shrinker/remove_shrinker API.

Great!  I checked bk://linux.bkbits.net/linux-2.5 before I started
assembling this patch set, but I missed the fact that the shrinker
changes had made it in.

> I'd appreciate it if you could pass an eye over that and give it
> a test.

Will do....

							- Ted
