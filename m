Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVDXV3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVDXV3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVDXV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:29:54 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:52889 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262440AbVDXV3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:29:41 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Sun, 24 Apr 2005 22:19:42 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DPofK-0000Yu-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 23:29:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
> > No.  You can't set "mount environment" in scp.
> 
> Of course you can.  It does execute the obvious set of rc files.

Don't think so.  ftp server and sftp server sure as hell don't.

> > Otherwise your analogy is nice, but misses a few points.  The usage of
> > mounts that we are talking about is much more dynamic than usage of
> > environment variables.
> 
> What the hell are you smoking and just how are you using shell?

Maybe differently from you :).  It's not that often that I have to
tweak environment variables.  They are usually set by scripts.

However if you write me a script that reads my mind as to which server
I want to mount with sshfs at which time, I give you all my respect.

Miklos

