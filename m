Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVFWBIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVFWBIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVFWBIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:08:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261946AbVFWBIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:08:48 -0400
Date: Wed, 22 Jun 2005 18:08:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vara Prasad <prasadav@us.ibm.com>
Cc: gh@us.ibm.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (kexec/kdump)
Message-Id: <20050622180813.01515fa4.akpm@osdl.org>
In-Reply-To: <42BA092A.7090408@us.ibm.com>
References: <20050621132204.1b57b6ba.akpm@osdl.org>
	<E1Dkpn1-0006va-00@w-gerrit.beaverton.ibm.com>
	<20050621140441.53513a7a.akpm@osdl.org>
	<42BA092A.7090408@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vara Prasad <prasadav@us.ibm.com> wrote:
>
> I think all the alternatives out there are less reliable than Kdump 
>  based on the design. Vendors are currently shipping other solutions 
>  since they didn't have any better alternatives until now. The existing 
>  solutions in the two major distro's doesn't work lot of times. I don't 
>  know what percentage of times they work as i only get involved when they 
>  don't work, but i can certainly tell you they don't work many a times. 
>  It is very embarrassing to tell the customer sorry we couldn't get dump 
>  can you try reproducing the problem again.  At least two major distros 
>  expressed interest in replacing their current solutions with kdump once 
>  it matures. As you are well aware we are doing testing with as many 
>  configurations as we can to iron out the bugs. Hope this addresses some 
>  of your concerns.

Yes, thanks.

And the meta-goodness here is that at least we have a *design* which is
acceptable from this-is-sane standpoint.  So at least everyone will be
pulling in the same direction.

So as I said, it's a bit of a bet at this point in time, but we've gone as
far as we can get with it out-of-tree, so let's merge it and hope that it
matures into an acceptably useful dumper.
