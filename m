Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVDXVNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVDXVNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVDXVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:13:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:3752 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262425AbVDXVNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:13:08 -0400
Date: Sun, 24 Apr 2005 22:12:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424211249.GA9304@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GA29151@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424210616.GA29151@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> > > I believe the point is:
> > > 
> > >    1. Person is logged from client Y to server X, and mounts something on
> > >       $HOME/mnt/private (that's on X).
> > > 
> > >    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
> > >       and wants it to work.
> > > 
> > > The second operation is a separate login to the first.
> > 
> > Solution?
> 
> just restart your shell.  Same way you do that after adjusting $PATH.

What do you mean?

I cannot think of any way restarting the shell would solve the above.

-- Jamie
