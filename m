Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUIBRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUIBRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIBRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:51:54 -0400
Received: from verein.lst.de ([213.95.11.210]:6567 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268030AbUIBRu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:50:58 -0400
Date: Thu, 2 Sep 2004 19:50:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902175034.GA18861@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jamie Lokier <jamie@shareable.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 10:46:32AM -0700, Linus Torvalds wrote:
> > On Mer, 2004-09-01 at 21:50, Linus Torvalds wrote:
> > > and quite frankly, I think you can do the above pretty much totally in
> > > user space with a small library and a daemon (in fact, ignoring security
> > > issues you probably don't even need the daemon). And if you can prototype
> > > it like that, and people actually find it useful, I suspect kernel support
> > > for better performance might be possible.
> > 
> > Gnome already supports this in the gnome-vfs2 layer. "MC" has supported
> > it since the late 1990's.
> 
> And nobody has asked for kernel support that I know of.
> 
> So either "it just works" in user space, or people haven't figured out the 
> kernel could help them. Or decided it's not worth it, exactly because 
> they'd still have to support systems/filesystems that can't be converted.

http://oss.oracle.com/projects/userfs/ has code that clues gnomevfs onto
a kernel filesystem.  The code is horrible, but it shows that it can
be done.
