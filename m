Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRASLoW>; Fri, 19 Jan 2001 06:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbRASLoM>; Fri, 19 Jan 2001 06:44:12 -0500
Received: from libra.cyb.it ([212.11.95.209]:59405 "EHLO relay2.flashnet.it")
	by vger.kernel.org with ESMTP id <S131369AbRASLoK>;
	Fri, 19 Jan 2001 06:44:10 -0500
Date: Fri, 19 Jan 2001 12:38:47 +0100
From: David Santinoli <u235@libero.it>
To: James Bottomley <J.E.J.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partition renumbering under 2.4.0
Message-ID: <20010119123847.D943@aidi.santinoli.com>
In-Reply-To: <200101171556.KAA01055@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101171556.KAA01055@localhost.localdomain>; from J.E.J.Bottomley@HansenPartnership.com on Wed, Jan 17, 2001 at 10:56:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 10:56:14AM -0500, James Bottomley wrote:
> Under 2.4, if you use devfs, the solaris (and other) slice recognition code
> could be enhanced to give the correct names to all the slices.  This would
> turn out to be something like /dev/ide/hdb2s7 (or something even worse---I'm
> afraid I only really know the naming scheme for SCSI devices) but at least you
> can find the exact slice you're looking for in an easy and intuitive way.
> 
> So, would you prefer the quick fix, or the more durable solution (which would 
> require you to change your fstab)?

Personally I'd be happy with the quick hack, but the slice-enhanced naming
scheme possible with devfs looks like the way to go.

Besides, I think that documenting this issue in the "Changes" file would help
somehow.

Thanks,
 David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
