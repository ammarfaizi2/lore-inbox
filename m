Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbSJHSfI>; Tue, 8 Oct 2002 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJHSfI>; Tue, 8 Oct 2002 14:35:08 -0400
Received: from thunk.org ([140.239.227.29]:30915 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261426AbSJHSfE>;
	Tue, 8 Oct 2002 14:35:04 -0400
Date: Tue, 8 Oct 2002 14:40:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021008184039.GA8174@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Ed Tomlinson <tomlins@cam.org>
References: <E17yymB-00021j-00@think.thunk.org> <20021008191900.A12912@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008191900.A12912@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:19:00PM +0100, Christoph Hellwig wrote:
> > This first patch creates a generic interface for registering caches with
> > the VM subsystem so that they can react appropriately to memory
> > pressure.
> 
> I'd suggest Ed Tomlinson's much saner interface that adds a third callbackj
> to kmem_cache_t (similar to the Solaris implementation) instead.

Can you give me a pointer to his stuff?  Thanks!

						- Ted	

> Doing this outside slab is not a good idea (and XFS currently does
> it too - in it's own code which should be replaced with Ed's one)

