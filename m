Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269201AbUIBVua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269201AbUIBVua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269214AbUIBVuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:50:17 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:38367 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269201AbUIBVsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:48:07 -0400
Date: Thu, 2 Sep 2004 23:48:06 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902214806.GA5272@janus>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094160994.31499.19.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 04:36:34PM -0500, Dave Kleikamp wrote:
> On Thu, 2004-09-02 at 15:38, Frank van Maarseveen wrote:
> > Can it do this:
> > 
> > 	cd FC2-i386-disc1.iso
> > 	ls
> > 
> > or this:
> > 
> > 	cd /dev/sda1
> > 	ls
> > 	cd /dev/floppy
> > 	ls
> > 	cd /dev/cdrom
> > 	ls
> > 
> > ?
> 
> We have the mount command for that.  :^)

mount is nice for root, clumsy for user. And a rather complicated
way of accessing data the kernel has knowledge about in the first
place. For filesystem images, cd'ing into the file is the most
obvious concept for file-as-a-dir IMHO.

-- 
Frank
