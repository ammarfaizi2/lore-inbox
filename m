Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVFHUox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFHUox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVFHUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:44:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:35515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261606AbVFHUov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:44:51 -0400
Date: Wed, 8 Jun 2005 13:44:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Manfred Georg <mgeorg@arl.wustl.edu>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities not inherited
Message-ID: <20050608204430.GC9153@shell0.pdx.osdl.net>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Manfred Georg (mgeorg@arl.wustl.edu) wrote:
> I was working with passing capabilities through an exec and it
> didn't do what I expected it to.  That is, if I set a bit in
> the inherited capabilities, it is not "inherited" after an
> exec().  After going through the code many times, and still not
> understanding it, I hacked together this patch.  It probably
> has unforseen side effects and there was probably some
> reason it was not done in the first place.

True to both.  If you'd like to work with this, check the archives for
similar patches.  Most recent in a thread from Alex Nyberg starting
here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111062795600730&w=2

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
