Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVEXJeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVEXJeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVEXJcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:32:04 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:58814 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261961AbVEXJP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:15:58 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091552.E3D05F9EE@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:15:52 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 2366BFB72

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:46 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261334AbVEXGsu (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:48:50 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEXGst

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:48:49 -0400

Received: from fire.osdl.org ([65.172.181.4]:20097 "EHLO smtp.osdl.org")

	by vger.kernel.org with ESMTP id S261334AbVEXGsj (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:48:39 -0400

Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])

	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O6mWjA025872

	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);

	Mon, 23 May 2005 23:48:32 -0700

Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])

	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O6mVWw012672;

	Mon, 23 May 2005 23:48:31 -0700

Date:	Mon, 23 May 2005 23:50:36 -0700 (PDT)

From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates

In-Reply-To: <4292CB01.6090506@pobox.com>

Message-ID: <Pine.LNX.4.58.0505232349020.2307@ppc970.osdl.org>

References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>

 <4292CB01.6090506@pobox.com>

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
> You really can't beat
> 
> 	cp .git/refs/heads/master .git/refs/heads/new-branch
> 
> as the fastest way to create a new branch off the tip.

So? It's the fastest, but it's also BROKEN. Exactly because the way you do 
things, the merge messages are meaningless.

So fix your merge messages. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

