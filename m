Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274636AbRITU2R>; Thu, 20 Sep 2001 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274635AbRITU2H>; Thu, 20 Sep 2001 16:28:07 -0400
Received: from ns.caldera.de ([212.34.180.1]:5840 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274636AbRITU14>;
	Thu, 20 Sep 2001 16:27:56 -0400
Date: Thu, 20 Sep 2001 22:26:43 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Steve Lord <lord@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source
Message-ID: <20010920222643.A7267@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Steve Lord <lord@sgi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Gonyou, Austin" <austin@coremetrics.com>,
	narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200109202016.f8KKGrL19642@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109202016.f8KKGrL19642@jen.americas.sgi.com>; from lord@sgi.com on Thu, Sep 20, 2001 at 03:16:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 03:16:52PM -0500, Steve Lord wrote:
> > > Won't there be a lot of changes which need to be made for it to go into 2.5
> > > anyway though beyond just current development? Isn't 2.5 supposed to be
> > > "radically" different?
> > 
> > Not really. 2.5 will change over time for certain but if anything the 2.5
> > changes will make it easier. One problem area with XFS is that it duplicates
> > chunks of what should be generic functionality - and 2.5 needs to provide
> > the generic paths it wants
> 
> Since we have your attention - which chunks? One of the frustrations we have
> had is the lack of feedback from anyone who has looked at XFS.

 o The whole vnode layer
 o checks already peformed by the VFS all over the place
   (just take a look at xfs_rename.c!)
 o the own quoata code
 o the hooks for a propritary clusterfs..

My 2 (euro-)cents,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
