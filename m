Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVCCQTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVCCQTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVCCQTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:19:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:38564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261927AbVCCQTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:19:18 -0500
Date: Thu, 3 Mar 2005 08:19:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303161901.GO28536@shell0.pdx.osdl.net>
References: <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <4226EE0F.1050405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4226EE0F.1050405@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> 1) There is no clear, CONSISTENT point where "bugfixes only" begins. 
> Right now, it could be -rc2, -rc3, -rc4... who knows.
> 
> We need to send a clear signal to users "this is when you can really 
> start hammering it."  A signal that does not change from release to 
> release.  A signal that does not require intimate knowledge of the 
> kernel devel process.
> 
> This is a key reason why we don't get more pre-release testing.
> 
> 2) After 2.6.11 release is out, there is no established process for "oh 
> shit, 2.6.11 users will really want that fixed."
> 
> --------------------
> 
> Linus's even/odd proposal is an example of a solution for problem #2, as 
> is my 2.6.X.Y proposal.
> 
> The 2.4.x series -pre/-rc is an example of a solution for problem #1.

This is exactly how I see it as well.  Guess we drank the same koolaid ;-)
I don't see the reluctance to use -pre/-rc since that's already what
we're doing (just poorly encoded in -rc$x).  Also, .x.y does require
some release discipline, there may be cases where the .x.y fix should be
much simpler than .x+1-pre/rc fix (as in Greg's comment that fixes may
include basic API changes).

thanks,
-chris
