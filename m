Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbSJGSej>; Mon, 7 Oct 2002 14:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbSJGSej>; Mon, 7 Oct 2002 14:34:39 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:27922 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262605AbSJGSei>; Mon, 7 Oct 2002 14:34:38 -0400
Date: Mon, 7 Oct 2002 19:40:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 3/4: evms_ioctl.h
Message-ID: <20021007194012.A25510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@math.psu.edu>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <20021007183415.A22316@infradead.org> <Pine.GSO.4.21.0210071340580.29030-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0210071340580.29030-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Oct 07, 2002 at 01:50:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 01:50:00PM -0400, Alexander Viro wrote:
> 
> 
> On Mon, 7 Oct 2002, Christoph Hellwig wrote:
> 
> > I don't think that basing kernel internal interfaces on ioctl is
> > a smart idea.  Just add another function pionter to your operations
> > vector for every operation you want supported on volumes.
> 
> s/every/& generic/.  Other than that, seconded.  BTW, one of the pending
> changes is taking the last more or less generic ioctl (HDIO_GETGEO) into
> a separate method...

Well, I implied generic ioctl as the EVMS "API" (aka collection of random
ioctls) is about that generic interface.

