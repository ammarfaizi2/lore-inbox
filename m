Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUIFKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUIFKyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUIFKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 06:54:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57786 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267537AbUIFKyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 06:54:17 -0400
Date: Mon, 6 Sep 2004 12:54:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Spam <spam@tnonline.net>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040906105416.GC28111@atrey.karlin.mff.cuni.cz>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net> <20040902194909.GA8653@atrey.karlin.mff.cuni.cz> <1094155277.11364.92.camel@krustophenia.net> <1094152590.5726.37.camel@localhost.localdomain> <20040905120758.GI26560@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905120758.GI26560@thundrix.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thats how you get yourself a non useful OS. Fix it in a library and
> > share it between the apps that care. Like say.. gnome-vfs2
> 
> Even KIOslave has  it. They even support sftp and  stuff just by using
> shared files  in /tmp in reality.  That's a much  saner interface than
> doing it all in the kernel.
> 
> I  mean,  the  kernel  is  supposed  to support  access  to  the  disk
> drives. Who says that it's got  to be the uppermost VFS level? You can
> be perfectly happy to build your own  VFS on top of it (or use other's
> implementations, that is.)

You can not reasonably do caching when you are in shared library. And
you can not do caching across users at all.

								Pavel
