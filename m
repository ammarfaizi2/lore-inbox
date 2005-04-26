Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVDZJWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVDZJWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDZJWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:22:38 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:24735 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261418AbVDZJWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:22:32 -0400
To: hch@infradead.org
CC: jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050426091921.GA29810@infradead.org> (message from Christoph
	Hellwig on Tue, 26 Apr 2005 10:19:21 +0100)
Subject: Re: [PATCH] private mounts
References: <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org>
Message-Id: <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 11:22:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The most important difference between orinary filesystems and FUSE is
> > the fact, that the filesystem data/metadata is provided by a userspace
> > process run with the privileges of the mount "owner" instead of the
> > kernel, or some remote entity usually running with elevated
> > privileges.
> 
> define "mount owner".  Right now mount requires CAP_SYS_ADMIN which means
> fairly privilegued.

FUSE uses a suid root helper (as explained below).  Please read the
whole mail.

Thanks,
Miklos
