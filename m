Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbTDBSZM>; Wed, 2 Apr 2003 13:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTDBSZM>; Wed, 2 Apr 2003 13:25:12 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:18703 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263079AbTDBSZL>; Wed, 2 Apr 2003 13:25:11 -0500
Date: Wed, 2 Apr 2003 19:36:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: videobuf update
Message-ID: <20030402193635.A1462@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@bytesex.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <20030402163647.GA24583@bytesex.org> <20030402190649.A1091@infradead.org> <20030402183544.GA26132@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030402183544.GA26132@bytesex.org>; from kraxel@bytesex.org on Wed, Apr 02, 2003 at 08:35:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 08:35:44PM +0200, Gerd Knorr wrote:
> > > --- linux-2.5.66/drivers/media/video/video-buf.c	2003-04-02 11:42:51.957723625 +0200
> > >  
> > > +#include <linux/version.h>
> > 
> > Why do you need this?
> 
> Because the 2.5.x code doesn't compile on 2.4.x, thus there are version
> #ifdefs in my device driver tarballs.  You just don't see that because
> some perl magic filteres out the 2.4 code when submitting patches for
> 2.5.x (and visa versa ...).  If you fetch the tarballs from bytesex.org
> you'll see the #ifdefs in the driver code.

So what about stripping #include <linux/version.h> in your script aswell? :)

