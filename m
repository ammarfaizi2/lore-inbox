Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUGNUNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUGNUNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUGNUNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:13:40 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:22986 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S267400AbUGNUNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:13:34 -0400
Date: Wed, 14 Jul 2004 16:15:59 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCH] Slowly update in-kernel orinoco drivers to upstream
 current CVS
In-Reply-To: <20040712213349.A2540@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.60.0407141605460.1799@marabou.research.att.com>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Francois Romieu wrote:

> A serie of patches is available for at:
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm7
>
> It contains 12 patches and applies against 2.6.7-mm7. The patches are
> commented. The comments are partly taken from the cvs log by Pavel Roskin.

I hope the patches lead to the CVS version on the "for_linus" branch which 
has no compatibility code.  I'm quite comfortable with the "for_linus" and 
"Standalone" branches.

As for the HEAD branch, it has unfinished (skeleton only) prism_usb driver 
meant for Intersil Prism USB devices (such as DWL-122).  It also has 
working orinoco_usb driver.  Unfortunately, I don't feel good about that 
code.  The way how this code is integrated with the common code is 
questionable.  A lot of work would be needed to handle USB better. 
That's not something that could be done before the next release.

I'm very busy now and I don't have time to finish the little bits I 
planned for the 0.15 release.  However, the CVS version on the "for_linus" 
branch is releasable and has no known regressions compared to any previous 
version.  Feel free to apply the patches to the kernel now.  I expect to 
have more time for free software in the end of August.

If David is OK, we could release the current code as version 0.15.  I'm OK 
with it.  I have to adapt my ambitions to my time constraints.  I'll 
appreciate if my name is added to the MAINTAINERS file once the new driver 
is committed.

-- 
Regards,
Pavel Roskin
