Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUIBXCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUIBXCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269258AbUIBXCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:02:06 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:23520 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269169AbUIBW4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:56:36 -0400
Date: Fri, 3 Sep 2004 00:56:34 +0200
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
Message-ID: <20040902225634.GA5756@janus>
References: <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <20040902220242.GA5414@janus> <20040902220640.GE23987@parcelfarce.linux.theplanet.co.uk> <20040902221133.GB5414@janus> <20040902221722.GF23987@parcelfarce.linux.theplanet.co.uk> <20040902222650.GA5523@janus> <20040902223324.GG23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902223324.GG23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 11:33:24PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> RTFS and you'll see.  Individual fs generally knows how to check if it
> would be immediately unhappy with given image (not all types do, BTW).
> Exact form of checks depends on fs type; for crying out loud, there's
> not even a promise that they are mutually exclusive!

so?

A user can stick an USB memory card with _any_ malformed fs data and
make troubles via the automounter or user mounts. Yes, mount might do
some more checks but it sure won't do an fsck.

The user gets what he deserves when sticking crap in an USB port.

And that doesn't mean that the kernel should accept any fs image
when a user tries to cd into the file.

-- 
Frank
