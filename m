Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274229AbRITChR>; Wed, 19 Sep 2001 22:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274293AbRITChJ>; Wed, 19 Sep 2001 22:37:09 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.133]:34947 "EHLO
	continuum.cm.nu") by vger.kernel.org with ESMTP id <S274229AbRITCgw>;
	Wed, 19 Sep 2001 22:36:52 -0400
Date: Wed, 19 Sep 2001 19:36:49 -0700
From: Shane Wegner <shane@cm.nu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010919193649.A8824@cm.nu>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz> <20010919153441.A30940@cm.nu> <20010920004543.Z720@athlon.random> <20010919193128.A8650@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919193128.A8650@cm.nu>
User-Agent: Mutt/1.3.20i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 07:31:28PM -0700, Shane Wegner wrote:
> On Thu, Sep 20, 2001 at 12:45:43AM +0200, Andrea Arcangeli wrote:
> > On Wed, Sep 19, 2001 at 03:34:41PM -0700, Shane Wegner wrote:
> > > 
> > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > c012e052
> > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > c012e052
> > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > c012e052
> > 
> > yes, please try this fix and let me know if it helps:
> 
> After some stress testing, the fix does appear to fix the
> error.

Hi,

Well just after I sent the email, it came up again.


Sep 19 19:31:52 continuum kernel: __alloc_pages: 0-order
allocation failed (gfp=0x20/0) from c012e052
Sep 19 19:33:51 continuum kernel: __alloc_pages: 0-order
allocation failed (gfp=0x20/0) from c012e052

Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
