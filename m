Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSJHSpu>; Tue, 8 Oct 2002 14:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJHSpt>; Tue, 8 Oct 2002 14:45:49 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56585 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261483AbSJHSpH>; Tue, 8 Oct 2002 14:45:07 -0400
Date: Tue, 8 Oct 2002 19:50:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021008195047.A14549@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Ed Tomlinson <tomlins@cam.org>
References: <E17yymB-00021j-00@think.thunk.org> <20021008191900.A12912@infradead.org> <20021008184039.GA8174@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008184039.GA8174@think.thunk.org>; from tytso@mit.edu on Tue, Oct 08, 2002 at 02:40:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 02:40:39PM -0400, Theodore Ts'o wrote:
> On Tue, Oct 08, 2002 at 07:19:00PM +0100, Christoph Hellwig wrote:
> > > This first patch creates a generic interface for registering caches with
> > > the VM subsystem so that they can react appropriately to memory
> > > pressure.
> > 
> > I'd suggest Ed Tomlinson's much saner interface that adds a third callbackj
> > to kmem_cache_t (similar to the Solaris implementation) instead.
> 
> Can you give me a pointer to his stuff?  Thanks!

It is/was in akpm's -mm tree (http://www.zip.com.au/~akpm/linux/patches/2.5/).
Ed, do you have a pointer to your most recent patch?

