Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVDYJ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVDYJ7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVDYJ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:59:22 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:12955 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262571AbVDYJ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:59:17 -0400
To: bulb@ucw.cz
CC: viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050425071047.GA13975@vagabond> (message from Jan Hudec on Mon,
	25 Apr 2005 09:10:47 +0200)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond>
Message-Id: <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Apr 2005 11:58:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Don't think so.  ftp server and sftp server sure as hell don't.
> 
> Sftp sure *DOES*. It is invoked by shell, which is not run as login one,
> but even non-login shell sources an rc file.

You win :)

> > However if you write me a script that reads my mind as to which server
> > I want to mount with sshfs at which time, I give you all my respect.
> 
> I can't write a script that reads your mind. But I sure can write
> a script that finds out what you mounted in the other shells (with help
> of a little wrapper around the mount command).

How do you bind mount it from a different namespace?  You _do_ need
bind mount, since a new mount might require password input, etc...

Thanks,
Miklos
