Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbTDBSXn>; Wed, 2 Apr 2003 13:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbTDBSXm>; Wed, 2 Apr 2003 13:23:42 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:6802 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263080AbTDBSXm>; Wed, 2 Apr 2003 13:23:42 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 2 Apr 2003 20:35:44 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: videobuf update
Message-ID: <20030402183544.GA26132@bytesex.org>
References: <20030402163647.GA24583@bytesex.org> <20030402190649.A1091@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402190649.A1091@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- linux-2.5.66/drivers/media/video/video-buf.c	2003-04-02 11:42:51.957723625 +0200
> >  
> > +#include <linux/version.h>
> 
> Why do you need this?

Because the 2.5.x code doesn't compile on 2.4.x, thus there are version
#ifdefs in my device driver tarballs.  You just don't see that because
some perl magic filteres out the 2.4 code when submitting patches for
2.5.x (and visa versa ...).  If you fetch the tarballs from bytesex.org
you'll see the #ifdefs in the driver code.

  Gerd

-- 
Michael Moore for president!
