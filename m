Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUIBRsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUIBRsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268030AbUIBRsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:48:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:50851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268064AbUIBRrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:47:22 -0400
Date: Thu, 2 Sep 2004 10:46:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent
 semantic changes with reiser4)
In-Reply-To: <1094118362.4847.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org> 
 <200408282314.i7SNErYv003270@localhost.localdomain> 
 <20040901200806.GC31934@mail.shareable.org>  <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Alan Cox wrote:
>
> On Mer, 2004-09-01 at 21:50, Linus Torvalds wrote:
> > and quite frankly, I think you can do the above pretty much totally in
> > user space with a small library and a daemon (in fact, ignoring security
> > issues you probably don't even need the daemon). And if you can prototype
> > it like that, and people actually find it useful, I suspect kernel support
> > for better performance might be possible.
> 
> Gnome already supports this in the gnome-vfs2 layer. "MC" has supported
> it since the late 1990's.

And nobody has asked for kernel support that I know of.

So either "it just works" in user space, or people haven't figured out the 
kernel could help them. Or decided it's not worth it, exactly because 
they'd still have to support systems/filesystems that can't be converted.

		Linus
