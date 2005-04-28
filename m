Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVD1IkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVD1IkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVD1IhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:37:08 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:18088 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261862AbVD1I3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:29:39 -0400
To: pavel@ucw.cz
CC: trond.myklebust@fys.uio.no, bulb@ucw.cz, hch@infradead.org,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050428082444.GK1906@elf.ucw.cz> (message from Pavel Machek on
	Thu, 28 Apr 2005 10:24:44 +0200)
Subject: Re: [PATCH] private mounts
References: <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond> <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu> <20050427123944.GA11020@vagabond> <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu> <20050427145842.GD28119@elf.ucw.cz> <1114644116.9947.14.camel@lade.trondhjem.org> <20050428082444.GK1906@elf.ucw.cz>
Message-Id: <E1DR4OA-0005UL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 10:28:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The NFS security model is based on the principle that the administrator
> > of the SERVER can override access permissions on his/her hardware. Pray
> > tell why you think that is "broken"?
> 
> Well, administrator on CLIENT can impersonate whoever he wants,

Not really.  Root squash has the very important effect that whatever
the client does, it cannot impersonate "root".

Miklos
