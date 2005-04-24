Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVDXVGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVDXVGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVDXVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:06:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14525 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262422AbVDXVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:06:03 -0400
Date: Sun, 24 Apr 2005 22:06:16 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPoCg-0000W0-00@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:59:46PM +0200, Miklos Szeredi wrote:
> > I believe the point is:
> > 
> >    1. Person is logged from client Y to server X, and mounts something on
> >       $HOME/mnt/private (that's on X).
> > 
> >    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
> >       and wants it to work.
> > 
> > The second operation is a separate login to the first.
> 
> Solution?

... is the same as for the same question with "set of mounts" replaced
with "environment variables".
