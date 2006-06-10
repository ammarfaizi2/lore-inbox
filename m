Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWFJDuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWFJDuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 23:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWFJDuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 23:50:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40906 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030225AbWFJDuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 23:50:13 -0400
Date: Sat, 10 Jun 2006 13:49:51 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610134951.B775761@wobbly.melbourne.sgi.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <20060609214200.GA18213@kevlar.burdell.org> <20060609151553.30097b44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060609151553.30097b44.akpm@osdl.org>; from akpm@osdl.org on Fri, Jun 09, 2006 at 03:15:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 03:15:53PM -0700, Andrew Morton wrote:
> Sonny Rao <sonny@burdell.org> wrote:
> > On Fri, Jun 09, 2006 at 10:35:43AM -0700, Andrew Morton wrote:
> > <snip> 
> > > All that being said, Linux's filesystems are looking increasingly crufty
> > > and we are getting to the time where we would benefit from a greenfield
> > > start-a-new-one.  
> > 
> > I'm curious about this comment; in what way are they _collectively_
> > looking crufty ? 
> 
> We seem to be lagging behind "the industry" in some areas - handling large
> devices, high bandwidth IO, sophisticated on-disk data structures, advanced
> manageability, etc.

Er, no.  I'm not aware of many filesystems that are in the same
league as XFS on those first three specific points.  It certainly
has "ondisk sophistication" very well covered, trust me. ;)

We are definately not lagging on handling large devices nor high
bandwidth I/O anyway - XFS serves up very close to the hardware
capabilities for high end hardware and it scales well.  One could
come up with a different list of areas where Linux filesystems
might be lagging, but that list above ain't right.

> I mean, although ZFS is a rampant layering violation and we can do a lot of
> the things in there (without doing it all in the fs!) I don't think we can
> do all of it.

*nod*.

cheers.

-- 
Nathan
