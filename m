Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269318AbUICGQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269318AbUICGQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269062AbUICGQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:16:48 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:20166 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269018AbUICGQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:16:09 -0400
Message-ID: <41380C2C.1030609@namesys.com>
Date: Thu, 02 Sep 2004 23:16:12 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Christoph Hellwig <hch@lst.de>, fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <4137B5F5.8000402@slaphack.com>
In-Reply-To: <4137B5F5.8000402@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think streams are a good thing, I think that all of the 
different pieces of additional functionality necessary to emulate them 
with files and directories are a good thing.

Keeping streams out of linux was one of the (less important) ideas 
behind reiser4.  Streams are a rigid hack.  The toolkit that can emulate 
them, is useful, and the perceived importance of that emulation will 
fade as people start to use the toolkit for things that are much more 
fun than streams.

I agree with most of the rest of what you say though David.

Hans


David Masover wrote:

> File-as-a-dir has numerous advantages, but enough have been discussed.
> Short list is image mounts, tarballs, streams, metas, and namespace
> unification.  Longer list and explanations can be found if you RTFA.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

