Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262904AbSJBAUj>; Tue, 1 Oct 2002 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJBAUj>; Tue, 1 Oct 2002 20:20:39 -0400
Received: from tapu.f00f.org ([66.60.186.129]:64421 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262904AbSJBAUi>;
	Tue, 1 Oct 2002 20:20:38 -0400
Date: Tue, 1 Oct 2002 17:26:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021002002606.GB27122@tapu.f00f.org>
References: <96096729@toto.iv> <15770.10847.884743.30282@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15770.10847.884743.30282@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 09:06:07AM +1000, Peter Chubb wrote:

> Indeed...  And I'm trying to merge it all now into 2.5.40.  Sorry
> I've been a bit slow --- testing, especially error testing when
> disks fill up, takes a long time (How long does it take to write 4
> TB to a disk?  About a day with the machines I have here.  Multiply
> that by three (now four with XFS) filesystems to test...)

With XFS, if you don't care about the file contents, you can create
very larges (multi-TB) non-sparse files more or less instantly.

If you want code for this, let me know and I'll hack something
together.


  --cw
