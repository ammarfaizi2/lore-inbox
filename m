Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTIXPh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 11:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbTIXPh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 11:37:27 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:32474 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261438AbTIXPh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 11:37:26 -0400
Date: Wed, 24 Sep 2003 08:37:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert Schwebel <robert@schwebel.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add 'make uImage' for PPC32
Message-ID: <20030924153720.GC23407@ip68-0-152-218.tc.ph.cox.net>
References: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net> <20030923060158.GJ8367@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923060158.GJ8367@pengutronix.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:01:58AM +0200, Robert Schwebel wrote:
> On Mon, Sep 22, 2003 at 11:29:28AM -0700, Tom Rini wrote:
> > Hello. The following BK patch adds support for a 'uImage' target on
> > PPC32. This will create an image for the U-Boot (and formerly PPCBoot)
> > firmware. The patch adds a scripts/mkuboot.sh as a wrapper for the
> > U-Boot mkimage program. We put mkuboot.sh into scripts/ because
> > U-Boot works on a number of other platforms, and it's likely that they
> > will add a uImage target at some point.  Please apply.
> 
> Integrating the U-Boot mkimage into the kernel would be a great thing
> for us Embedded folks (U-Boot supports most interesting platforms these
> days), but I don't like your way to provide a script wrapper around the
> "real" mkimage; I'm not sure what the maintainers think about this but I
> would prefer a "native" mkuimage.c -> mkuimage.  

>From what I recall this originally (when it was 'pImage') came from
Wolfgang, or at least he was happy with it.  If someone else wants to
fight for the inclusion of the true mkimage.c program from U-Boot,
that's fine with me.

-- 
Tom Rini
http://gate.crashing.org/~trini/
