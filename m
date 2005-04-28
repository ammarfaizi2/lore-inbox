Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVD1IkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVD1IkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVD1IhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:37:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22215 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261898AbVD1IZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:25:06 -0400
Date: Thu, 28 Apr 2005 10:24:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bulb@ucw.cz, hch@infradead.org,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] private mounts
Message-ID: <20050428082444.GK1906@elf.ucw.cz>
References: <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond> <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu> <20050427123944.GA11020@vagabond> <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu> <20050427145842.GD28119@elf.ucw.cz> <1114644116.9947.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114644116.9947.14.camel@lade.trondhjem.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 27-04-05 19:21:56, Trond Myklebust wrote:
> on den 27.04.2005 Klokka 16:58 (+0200) skreiv Pavel Machek:
> 
> > > 
> > > And b) is _the_ most important feature IMO, so the argument for
> > > stripping it out has to be very good.
> > 
> > Well, you'll have problems with suid programs suddenly not being able
> > to access files. nfs gets away with it, but nfs is perceived as
> > "broken" anyway...
> 
> Really?
> 
> The NFS security model is based on the principle that the administrator
> of the SERVER can override access permissions on his/her hardware. Pray
> tell why you think that is "broken"?

Well, administrator on CLIENT can impersonate whoever he wants, and if
data happens to be cached, he can just read them from local memory. So
whatever SERVER administrator does, CLIENT administrator can work
around.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
