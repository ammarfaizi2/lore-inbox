Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTEAItQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 04:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTEAItP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 04:49:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261176AbTEAItP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 04:49:15 -0400
Date: Thu, 1 May 2003 11:01:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, David Woodhouse <dwmw2@redhat.com>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>, linux-kernel@vger.kernel.org,
       greg@kroah.com, rddunlap@osdl.org
Subject: Re: 2.5.68-bk10 blkmtd.c:219: warning: implicit declaration offunction `alloc_kiovec'
Message-ID: <20030501090131.GQ14959@fs.tum.de>
References: <1051745126.5274.22.camel@flat41> <1051747119.5315.28.camel@flat41> <20030430171047.2f22ed70.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430171047.2f22ed70.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 05:10:47PM -0700, Andrew Morton wrote:
> Grzegorz Jaskiewicz <gj@pointblue.com.pl> wrote:
> >
> >   struct kiobuf *iobuf;
> > 	^^^^^^^
> >   unsigned long *blocks;
> > 
> > Fast fgrep in kernel sources gives me no answer about this structure declaration.
> > 
> 
> blkmtd died when kiobufs were removed.  The maintainer said "oh well, OK, I
> need to rewrite it anyway" but that obviously has not yet happened.

There's a new blkmtd in the MTD CVS.

David:
What are your current plans regarding merging the MTD CVS into 2.5?

cu
Adrian

[1] http://www.linux-mtd.infradead.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

