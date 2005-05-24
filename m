Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVEXLHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVEXLHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVEXJYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:24:48 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:12997 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261999AbVEXJT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:19:26 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091925.73B67F9FE@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:19:25 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 7C555FB73

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:46 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261416AbVEXHrr (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 03:47:47 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVEXHrr

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 03:47:47 -0400

Received: from fire.osdl.org ([65.172.181.4]:48015 "EHLO smtp.osdl.org")

	by vger.kernel.org with ESMTP id S261416AbVEXHrp (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 03:47:45 -0400

Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])

	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O7iVjA029720

	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);

	Tue, 24 May 2005 00:44:31 -0700

Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])

	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O7iUjI014722;

	Tue, 24 May 2005 00:44:30 -0700

Date:	Tue, 24 May 2005 00:46:35 -0700 (PDT)

From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates

In-Reply-To: <4292D7E1.80601@pobox.com>

Message-ID: <Pine.LNX.4.58.0505240042550.2307@ppc970.osdl.org>

References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>

 <4292C8EF.3090307@pobox.com> <Pine.LNX.4.58.0505232343260.2307@ppc970.osdl.org>

 <4292D7E1.80601@pobox.com>

MIME-Version: 1.0

Content-Type: TEXT/PLAIN; charset=US-ASCII

X-Spam-Status: No, hits=0 required=5 tests=

X-Spam-Checker-Version:	SpamAssassin 2.63-osdl_revision__1.40__

X-MIMEDefang-Filter: osdl$Revision: 1.109 $

X-Scanned-By: MIMEDefang 2.36

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org





On Tue, 24 May 2005, Jeff Garzik wrote:
> 
> Ok, I'll fix the commit message.
> 
> As for different trees, I'm afraid you've written something that is _too 
> useful_ to be used in that manner.

I really think you'll eventually confuse yourself terminally, but as long 
as the commit messages end up being meaningful, your "mush everything 
together" clearly is the thing that is going to perform best.

> Git has brought with it a _major_ increase in my productivity because I 
> can now easily share ~50 branches with 50 different kernel hackers, 
> without spending all day running rsync.

Hey, I'm happy it works for you, but are you sure those 50 other kernel 
hackers aren't confused?

IOW, your work model is pretty extreme, and I'm much more worried about 
mixing up trees by mistake than about the technical side of git per se. 
That's also why I think it's important that the commit logs are 
meaningful: they do end up containing the SHA1 key, so clearly "all the 
information" is there, but if something gets mixed up, I'd like some human 
to be able to eventualyl say "Aaahhh.. _that's_ where it got mixed up".

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

