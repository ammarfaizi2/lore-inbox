Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUGVFrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUGVFrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 01:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266812AbUGVFrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 01:47:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:44433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266808AbUGVFrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 01:47:51 -0400
Date: Thu, 22 Jul 2004 01:46:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: dpf-lkml@fountainbay.com
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040722014649.309bc26f.akpm@osdl.org>
In-Reply-To: <4411.24.6.231.172.1090470409.squirrel@24.6.231.172>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<20040721230044.20fdc5ec.akpm@osdl.org>
	<4411.24.6.231.172.1090470409.squirrel@24.6.231.172>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dpf-lkml@fountainbay.com wrote:
>
> Hopefully someone else will follow up, but I hope I'm somewhat convincing:

Not really ;)

Your points can be simplified to "I don't use cryptoloop, but someone else
might" and "we shouldn't do this in a stable kernel".

Well, I want to hear from "someone else".  If removing cryptoloop will
irritate five people, well, sorry.  If it's 5,000 people, well maybe not.


Yes, I buy the "stable kernel" principle, but here we have an example where
it conflicts with the advancement of the kernel, and we need to make a
judgement call.


Actually, my most serious concern with cryptoloop is the claim that it is
insufficiently secure.  If this is true then we'd be better off removing
the feature altogether rather than (mis)leading our users into thinking
that their data is secure.
