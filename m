Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269177AbUIBWRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269177AbUIBWRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUIBWP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:15:27 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:58079 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269149AbUIBWLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:11:40 -0400
Date: Fri, 3 Sep 2004 00:11:33 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902221133.GB5414@janus>
References: <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <20040902220242.GA5414@janus> <20040902220640.GE23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902220640.GE23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 11:06:40PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Sep 03, 2004 at 12:02:42AM +0200, Frank van Maarseveen wrote:
> > > a) kernel has *NO* *FUCKING* *KNOWLEDGE* of fs type contained on a device.
> > 
> > excuse me, but how does the kernel mount the root fs?
> 
> By trying all fs types it has registered in a more or less random (OK, defined
> by order of fs type registration, which is kinda-sorta deterministic at
> boot time) order.  With no flags, unless you pass them explicitly in kernel
> command line.  Fs types list can also be set explicitly in the command line.

Of course I know that: the point is, the kernel _has_ knowlegde contrary
to what you blatantly said.

-- 
Frank
