Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278089AbRJKE2z>; Thu, 11 Oct 2001 00:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278090AbRJKE2r>; Thu, 11 Oct 2001 00:28:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30891 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278089AbRJKE2c>;
	Thu, 11 Oct 2001 00:28:32 -0400
Date: Thu, 11 Oct 2001 00:29:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Chris Mason <mason@suse.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>,
        Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
In-Reply-To: <20011011001620.A18775@redhat.com>
Message-ID: <Pine.GSO.4.21.0110110027370.21168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Benjamin LaHaise wrote:

> On Wed, Oct 10, 2001 at 09:48:41PM -0400, Chris Mason wrote:
> > The bug where dump could corrupt things was when getblk and the
> > block device both used the buffer cache.  That issue hasn't changed.
> 
> Let me emphasize this: 2.4.11+ will still exhibit filesystem corruption if 
> the block device is accessed.  The only way to avoid this is to use raw io, 

What?  Details, please.  If you are talking about read access I would
really like to know which filesystem it is.  ext2 used to have a bug
in that area, but it had been fixed months ago.

