Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVDXVGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVDXVGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVDXVGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:06:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25227 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262426AbVDXVGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:06:17 -0400
Date: Sun, 24 Apr 2005 22:06:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424210616.GA29151@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPoCg-0000W0-00@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:59:46PM +0200, Miklos Szeredi wrote:
> > Could we please get of references to requirements without a rationale?
> > There's quite enough of that from Carrion-Grade Linux crowd, TYVM.
> 
> The rationale has been explained in that thread.  E.g. this quote from
> Jamie Lokier in an answer to you:

You still haven't written down coheren requirements.

> 
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

just restart your shell.  Same way you do that after adjusting $PATH.

