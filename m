Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVD3KQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVD3KQA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 06:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVD3KP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 06:15:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:32688 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261181AbVD3KO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 06:14:28 -0400
To: jamie@shareable.org
CC: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050430094218.GA32679@mail.shareable.org> (message from Jamie
	Lokier on Sat, 30 Apr 2005 10:42:18 +0100)
Subject: Re: [PATCH] private mounts
References: <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org>
Message-Id: <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 12:14:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, if you can find a way to tell the userspace FUSE daemon to know
> that the mount is being done by the same user as the existing mount,
> you don't need (or want) to check the credentials - you want the FUSE
> daemon to tell the kernel code which superblock to reuse.

It sounds very _very_ complicated compared to just using bind mounts.

And maybe the user _does_ want a new connection to the same server
(for whatever reason).  Why should we _force_ a sharing of
superblocks?

Miklos
