Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTLOMLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTLOMLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:11:31 -0500
Received: from main.gmane.org ([80.91.224.249]:11464 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263539AbTLOML3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:11:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: RFC - tarball/patch server in BitKeeper
Date: Mon, 15 Dec 2003 15:11:26 +0300
Message-ID: <20031215151126.3fe6e97a.vsu@altlinux.ru>
References: <20031214172156.GA16554@work.bitmover.com>
	<2259130000.1071469863@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Newsreader: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Cc: bitkeeper-users@bitmover.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Dec 2003 22:31:04 -0800 Martin J. Bligh wrote:

> One thing that I've wished for in the past which looks like it *might*
> be trivial to do is to grab a raw version of the patch you already
> put out in HTML format, eg if I surf down changesets and get to a page
> like this:
> 
> http://linus.bkbits.net:8080/linux-2.5/patch@1.1522?nav=index.html|ChangeSet@-2w|cset@1.1522
> 
> except it got html formatted, so I can't play with it easily. Is there
> any way to provide the raw format of that? If not, or you don't want to,
> no problem - would just be convenient. This isn't a open source vs not
> issue, it's just I often want one fix without the whole tree, and it'd
> be a convenient place to grab it.

You almost can do this now - in most cases, copying the text from
Mozilla gives a good patch. The only problem is that the HTML
generation code seems to have a bug - it correctly escapes '<' as
"&lt;" and '>' as "&gt;", but does not escape '&' as "&amp;", and this
occasionally leads to problems.

I see another missing feature - there does not seem to be a way to
order the changesets by the order of merging them into the tree. E.g.
when you look at the linux-2.4 changesets, you will now find XFS all
over the place - even before 2.4.23, while it really has been merged
after 2.4.23.

