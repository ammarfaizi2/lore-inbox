Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWGaQk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWGaQk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWGaQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:40:26 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:27109 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030232AbWGaQkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:40:25 -0400
Date: Mon, 31 Jul 2006 18:34:30 +0200
To: Neil Brown <neilb@suse.de>
Cc: Alexandre Oliva <aoliva@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
Message-ID: <20060731163429.GA6464@aitel.hist.no>
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br> <20060730124139.45861b47.akpm@osdl.org> <orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br> <17613.16090.470524.736889@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17613.16090.470524.736889@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:20:58AM +1000, Neil Brown wrote:
> 
> My first inclination is not to fix this problem.
> 
> I consider md auto-detect to be a legacy feature.
> I don't use it and I recommend that other people don't use it.
> However I cannot justify removing it, so it stays there.
> Having this limitation could be seen as a good motivation for some
> more users to stop using it.
> 
> Why not use auto-detect?
[Arguments deleted]

Well, if autodetection is removed, what is then the preferred
way of booting off a raid-1 device?

Kernel parameters?

An initrd with mdadm just for this?  Some people want to do even
partition detection from initrd, in order to have a smaller
kernel.  We aren't there yet though.

Autotetect is nice from an administrator viewpoint - compile
it in and it "just works".  The trouble when you connect
an array from some other machine is to be expected, but 
that isn't exactly everyday stuff.  

Helge Hafting
