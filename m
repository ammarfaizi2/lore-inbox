Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVD1LgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVD1LgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVD1LgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:36:10 -0400
Received: from pat.uio.no ([129.240.130.16]:39389 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262068AbVD1Lfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:35:48 -0400
Subject: Re: [PATCH] private mounts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bulb@ucw.cz, hch@infradead.org,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050428082444.GK1906@elf.ucw.cz>
References: <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond>
	 <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu>
	 <20050427123944.GA11020@vagabond>
	 <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
	 <20050427145842.GD28119@elf.ucw.cz>
	 <1114644116.9947.14.camel@lade.trondhjem.org>
	 <20050428082444.GK1906@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 07:35:17 -0400
Message-Id: <1114688117.10083.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.639, required 12,
	autolearn=disabled, AWL 1.31, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 28.04.2005 Klokka 10:24 (+0200) skreiv Pavel Machek:

> Well, administrator on CLIENT can impersonate whoever he wants, and if
> data happens to be cached, he can just read them from local memory. So
> whatever SERVER administrator does, CLIENT administrator can work
> around.

This is why you have identity squashing and/or strong security: to stop
the CLIENT administrator impersonating whoever he wants and working
around your security measures.

Yes there's all the FUD about how the administrator can still take over
your RPCSEC_GSS creds and/or read cached data once you have logged in.
If you log into a compromised client then you're screwed. What's new?

Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

