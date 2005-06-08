Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVFHVzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVFHVzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVFHVzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:55:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:63182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262029AbVFHVzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:55:02 -0400
Date: Wed, 8 Jun 2005 14:54:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Manfred Georg <mgeorg@arl.wustl.edu>
Cc: Alexander Nyberg <alexn@telia.com>, Chris Wright <chrisw@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities not inherited
Message-ID: <20050608215425.GD13152@shell0.pdx.osdl.net>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu> <20050608204430.GC9153@shell0.pdx.osdl.net> <1118265642.969.12.camel@localhost.localdomain> <Pine.LNX.4.62.0506081627170.11409@polyester.arl.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506081627170.11409@polyester.arl.wustl.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Manfred Georg (mgeorg@arl.wustl.edu) wrote:
> 
> On Wed, 8 Jun 2005, Alexander Nyberg wrote:
> >btw since the last discussion was about not changing the existing
> >interface and thus exposing security flaws, what about introducing
> >another prctrl that says maybe PRCTRL_ACROSS_EXECVE?
> 
> Wasn't the original inherited set supposed take care of that?

The filesystem part was quite integral to the original intent.

> >Any new user-space applications must understand the implications of
> >using it so it's safe in that aspect. Yes?
> 
> As far as I can tell, applying the patch from the earlier discussion
> and setting the inherited set has the same, "I really meant to do this"
> effect as what you propose.
> 
> >(yeah it's rather silly since there already is an unused
> >keep_capabilities flag but that would change old interfaces so ok)
> 
> Isn't the keep_capabilities flag related to setuid() ? or did I miss
> something.

Yes, it is, but it's tempting to reuse to really keep them. I think
that's the point.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
