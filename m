Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUIGGsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUIGGsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUIGGsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:48:25 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:12533 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267662AbUIGGsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:48:24 -0400
Date: Mon, 6 Sep 2004 23:47:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040907064740.GA31444@taniwha.stupidest.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <20040901194445.GM26192@nysv.org> <16701.22655.230704.534640@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16701.22655.230704.534640@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 04:43:11PM +1000, Neil Brown wrote:

> It seems to imply that "iso9660" shouldn't be in the kernel.  After
> all, it just exports information that is already in the underlying
> device.

Some applications do isofs/udf in userspace, DVD playback for example.

> It doesn't provide any "mediate multiple access" benefit as a
> read-only filesystem doesn't require any mediation between users.

Umm... you can have permissions for users and you need the kernel to
determine who can access what.



  --cw
