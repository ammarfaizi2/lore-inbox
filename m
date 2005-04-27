Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVD0XWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVD0XWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVD0XWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 19:22:21 -0400
Received: from pat.uio.no ([129.240.130.16]:42138 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262093AbVD0XWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 19:22:15 -0400
Subject: Re: [PATCH] private mounts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bulb@ucw.cz, hch@infradead.org,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050427145842.GD28119@elf.ucw.cz>
References: <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond>
	 <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu>
	 <20050427123944.GA11020@vagabond>
	 <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
	 <20050427145842.GD28119@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 19:21:56 -0400
Message-Id: <1114644116.9947.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.864, required 12,
	autolearn=disabled, AWL 1.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 27.04.2005 Klokka 16:58 (+0200) skreiv Pavel Machek:

> > 
> > And b) is _the_ most important feature IMO, so the argument for
> > stripping it out has to be very good.
> 
> Well, you'll have problems with suid programs suddenly not being able
> to access files. nfs gets away with it, but nfs is perceived as
> "broken" anyway...

Really?

The NFS security model is based on the principle that the administrator
of the SERVER can override access permissions on his/her hardware. Pray
tell why you think that is "broken"?

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

