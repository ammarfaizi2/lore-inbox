Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWCaTbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWCaTbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCaTbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:31:35 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:27050 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751442AbWCaTbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:31:34 -0500
To: trond.myklebust@fys.uio.no
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <1143830693.8085.19.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 31 Mar 2006 13:44:53 -0500)
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
	 <1143829641.8085.7.camel@lade.trondhjem.org> <1143830693.8085.19.camel@lade.trondhjem.org>
Message-Id: <E1FPPKx-0005nC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 21:31:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However you are also changing the behaviour of F_SETLK for the case
> where the user is trying to up/downgrade a set of existing READ/WRITE
> locks. Again you may end up with a situation where some of the existing
> locks get up/downgraded, and yet the lock request fails.

Can you please point out the exact case when this happens?

I've carefully reviewd the code, and found none.

Thanks,
Miklos
