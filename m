Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269151AbUIBWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbUIBWRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269155AbUIBWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:12:08 -0400
Received: from verein.lst.de ([213.95.11.210]:3244 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269238AbUIBWFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:05:07 -0400
Date: Fri, 3 Sep 2004 00:04:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, Frank van Maarseveen <frankvm@xs4all.nl>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902220444.GA23645@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Frank van Maarseveen <frankvm@xs4all.nl>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Jamie Lokier <jamie@shareable.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
	fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <20040902220242.GA5414@janus> <20040902220354.GA23618@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902220354.GA23618@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 12:03:54AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 03, 2004 at 12:02:42AM +0200, Frank van Maarseveen wrote:
> > On Thu, Sep 02, 2004 at 11:00:27PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > 
> > > The hell it is.
> > > 
> > > a) kernel has *NO* *FUCKING* *KNOWLEDGE* of fs type contained on a device.
> > 
> > excuse me, but how does the kernel mount the root fs?
> 
> trial and error.  That's why you see all thos ext3 mounted as ext2
> problems, or $RANDOMFS as fat.

Andb btw, for an lkml discussion RTFS wouldn't hurt.
