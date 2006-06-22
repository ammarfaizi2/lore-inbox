Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbWFVXfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWFVXfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWFVXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:35:51 -0400
Received: from colin.muc.de ([193.149.48.1]:41225 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932700AbWFVXfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:35:50 -0400
Date: 23 Jun 2006 01:35:49 +0200
Date: Fri, 23 Jun 2006 01:35:49 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
Message-ID: <20060622233549.GA55538@muc.de>
References: <20060622205928.GA23801@havoc.gtf.org> <20060622142430.3219f352.akpm@osdl.org> <20060622223919.GB50270@muc.de> <20060622155943.27c98d61.akpm@osdl.org> <449B268E.4000808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449B268E.4000808@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 07:23:58PM -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> >I don't think Jeff has sent us an example .config, but I hit this a few
> >times too, before we fixed it.  I think this was all triggered by a Kconfig
> >change in the AGP tree, so you wouldn't have seen it, but -mm did.
> 
> 'make allmodconfig' on x86-64.  You can create this .config yourself :)
> 
> I think the tree suffers [sometimes due to me :(] when 'allyesconfig' 
> and 'allmodconfig' stop working.

Yes, but they work in 2.6.17 right? 
And nothing should have changed since 2.6.17 so far.

But apparently something did. What was it?

-Andi
