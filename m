Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTDXAFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTDXAFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:05:39 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:51843 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264339AbTDXAFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:05:38 -0400
Date: Thu, 24 Apr 2003 10:17:33 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>, mbligh@aracnet.com, ncunningham@clear.net.nz,
       gigerstyle@gmx.ch, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424001733.GB678@zip.com.au>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423170759.2b4e6294.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 05:07:59PM -0700, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > If you really want to "solve" it reliably, you can always
> > 
> > swapon /dev/hdfoo666
> 
> Seems that using a swapfile instead of a swapdev would fix that neatly.
> 
> But iirc, suspend doesn't work with swapfiles.  Is that correct?  If so,
> what has to be done to get it working?

I'm curious. What does a swapfile solve that a swapdev does not? Either
way you need to prealloc the case (either have a chunky file in a
partition or a partition set aside) or you need to keep enough room
avail to fit the file when it's needed.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
