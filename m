Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269454AbUICAWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269454AbUICAWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269443AbUICAUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:20:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:49792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269430AbUICATd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:19:33 -0400
Date: Thu, 2 Sep 2004 17:18:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Masover <ninja@slaphack.com>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4137B5F5.8000402@slaphack.com>
Message-ID: <Pine.LNX.4.58.0409021717220.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus>
 <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus>
 <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk>
 <4137B5F5.8000402@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, David Masover wrote:
> 
> reiser4 kernel will contain knowledge of fs type contained in a file.

That's a disaster, btw.

There is no one "fs type" of a file. Files have at _least_ one type
(bytestream), but most have more. Which is why automatically doing the
right thing (in the sense you seem to want) in kernel space is simply not
possible.

			Linus
