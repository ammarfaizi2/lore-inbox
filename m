Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTLOGbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLOGbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:31:14 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:21701 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263019AbTLOGbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:31:12 -0500
Date: Sun, 14 Dec 2003 22:31:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
cc: bitkeeper-users@bitmover.com
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <2259130000.1071469863@[10.10.2.4]>
In-Reply-To: <20031214172156.GA16554@work.bitmover.com>
References: <20031214172156.GA16554@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've prototyped an extension to BitKeeper that provides tarballs
> and patches.  The idea is to make it possible for all trees hosted by
> bkbits.net provide access to the data with a free client (included below
> in prototype form).
> 
> The system is simplistic, it just provides a way to get the most recent
> sources as a tarball and then any later updates as a patch.  There is
> no provision for generating diffs, editing files, merging, etc.  All of
> that is something that you can write, if you want, using standard tools
> (think hard linked trees).
> 
> Before rolling this out, I want to know if this is going to (finally)
> put to rest any complaints about BK not being open source, available on
> all platforms, etc.  You need to understand that this is all you get,
> we're not going to extend this so you can do anything but track the most
> recent sources accurately.  No diffs.  No getting anything but the most
> recent version.  No revision history.  
> 
> If you want anything other than the most recent version your choices
> are to use BitKeeper itself or, if you want the main branches of the
> Linux kernel, the BK2CVS exports.  This is not a gateway product, it
> is a way for developers to track the latest and greatest with a free
> (source based) client.  It is not a way to convert BK repos to $SCM.
> 
> If the overwhelming response is positive then I'll add this to the
> bkbits.net server and perhaps eventually to the BK product itself.

That looks very cool to me at least - I'd find it helpful, I think.
Thank you.

One thing that I've wished for in the past which looks like it *might*
be trivial to do is to grab a raw version of the patch you already
put out in HTML format, eg if I surf down changesets and get to a page
like this:

http://linus.bkbits.net:8080/linux-2.5/patch@1.1522?nav=index.html|ChangeSet@-2w|cset@1.1522

except it got html formatted, so I can't play with it easily. Is there
any way to provide the raw format of that? If not, or you don't want to,
no problem - would just be convenient. This isn't a open source vs not
issue, it's just I often want one fix without the whole tree, and it'd
be a convenient place to grab it.

>  * Licensed under the NWL - No Whining License.
>  *
>  * You may use this, modify this, redistribute this provided you agree:
>  * - not to whine about this product or any other products from BitMover, Inc.
>  * - that there is no warranty of any kind.
>  * - retain this copyright in full.

;-)

M.

PS. If you could possibly generate the diffs with -p, whether you supply
them in raw format or not, it'd make them easier to read.

