Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUG2BhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUG2BhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUG2BhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:37:16 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:17589 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267404AbUG2BhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:37:15 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] don't pass mem_map into init functions
Date: Wed, 28 Jul 2004 18:33:55 -0700
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-mm <linux-mm@kvack.org>,
       LSE <lse-tech@lists.sourceforge.net>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidm@hpl.hp.com, tony.luck@intel.com
References: <1091048123.2871.435.camel@nighthawk> <200407281539.40049.jbarnes@engr.sgi.com> <1091056702.2871.617.camel@nighthawk>
In-Reply-To: <1091056702.2871.617.camel@nighthawk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281833.55574.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28, 2004 4:18 pm, Dave Hansen wrote:
> On Wed, 2004-07-28 at 15:39, Jesse Barnes wrote:
> > You're missing this little bit from your patchset.  Cc'ing Tony and
> > David.
>
> Thanks for finding that.  That appears to be an ia64-ism, so I think the
> rest of the patch is OK.

Well, it booted anyway :).  I didn't check to see if any other arches had 
their own memmap_init routines though, I'm assuming you already covered 
those.

Jesse
