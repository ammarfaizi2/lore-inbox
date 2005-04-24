Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVDXUuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVDXUuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVDXUuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:50:16 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:35993 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262411AbVDXUuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:50:11 -0400
To: hch@infradead.org
CC: linux-fsdevel@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050424201820.GA28428@infradead.org> (message from Christoph
	Hellwig on Sun, 24 Apr 2005 21:18:20 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org>
Message-Id: <E1DPo3I-0000V0-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 22:50:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This simple patch adds support for private (or invisible) mounts.  The
> > rationale is to allow mounts to be private for a user but still in the
> > global namespace.
> 
> As mentioned in the last -fsdevel thread a few times the idea of per-user
> mounts is fundamentally flawed.  Crossing a namespace boundary must be
> explicit - using clone or a new unshare() syscall.

Also mentioned in that thread quite a few times is the fact the the
clone() and unshare() modell does not solve people's requirements.

Care to read through that thread and suggest an alternative solution?

Thanks,
Miklos
