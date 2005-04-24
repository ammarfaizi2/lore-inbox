Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVDXVAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVDXVAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVDXVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:00:11 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:40857 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262419AbVDXVAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:00:05 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Sun, 24 Apr 2005 21:54:22 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DPoCg-0000W0-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 22:59:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also mentioned in that thread quite a few times is the fact the the
> > clone() and unshare() modell does not solve people's requirements.
> 
> Could we please get of references to requirements without a rationale?
> There's quite enough of that from Carrion-Grade Linux crowd, TYVM.

The rationale has been explained in that thread.  E.g. this quote from
Jamie Lokier in an answer to you:

> I believe the point is:
> 
>    1. Person is logged from client Y to server X, and mounts something on
>       $HOME/mnt/private (that's on X).
> 
>    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
>       and wants it to work.
> 
> The second operation is a separate login to the first.

Solution?

Thanks,
Miklos
