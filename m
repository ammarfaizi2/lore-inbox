Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263275AbVCKCKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbVCKCKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbVCKCHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:07:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17792 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263108AbVCKCGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:06:02 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Paul Mackerras <paulus@samba.org>, werner@sgi.com
Subject: Re: AGP bogosities
Date: Thu, 10 Mar 2005 18:04:04 -0800
User-Agent: KMail/1.7.2
Cc: torvalds@osdl.org, davej@redhat.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
In-Reply-To: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503101804.04371.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 10, 2005 5:24 pm, Paul Mackerras wrote:
> The patch below fixes these problems.  It will work in the 99.99% of
> cases where we have one AGP bridge and one AGP video card.  We should
> eventually cope with multiple AGP bridges, but doing the matching of
> bridges to video cards is a hard problem because the video card is not
> necessarily a child or sibling of the PCI device that we use for
> controlling the AGP bridge.  I think we need to see an actual example
> of a system with multiple AGP bridges first.

We have real systems with multiple AGP bridges out there already, so we'd like 
to see this fixed properly.  I think this is Mike's code, Mike?

> Oh, and by the way, I have 3D working relatively well on my G5 with a
> 64-bit kernel (and 32-bit X server and clients), which is why I care
> about AGP 3.0 support. :)

I have a system in my office with several gfx pipes on different AGP busses, 
and I'd like that to work well too! :)

Jesse
