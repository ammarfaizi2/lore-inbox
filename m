Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUBCXiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUBCXiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:38:11 -0500
Received: from waste.org ([209.173.204.2]:27347 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266176AbUBCXiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:38:07 -0500
Date: Tue, 3 Feb 2004 17:37:37 -0600
From: Matt Mackall <mpm@selenic.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Clay Haapala <chaapala@cisco.com>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040203233737.GD31138@waste.org>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com> <20040203172508.B26222@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203172508.B26222@lists.us.dell.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 05:25:08PM -0600, Matt Domsch wrote:
> > >> +MODULE_LICENSE("GPL and additional rights");
> > > 
> > > "additional rights?"
> > > 
> > Take it up with Matt_Domsch@dell.com -- it's his code that I
> > cribbed, so that's the license line I used.
> 
> The crc32 code came from linux@horizon.com with the following
> copyright abandonment disclaimer, which is still in lib/crc32.c:
> 
> /*
>  * This code is in the public domain; copyright abandoned.
>  * Liability for non-performance of this code is limited to the amount
>  * you paid for it.  Since it is distributed for free, your refund will
>  * be very very small.  If it breaks, you get to keep both pieces.
>  */
> 
> Thus GPL plus additional rights is appropriate.

Ok, makes sense for CRC32 stuff which can be easily lifted from the
kernel or 50 other places, but not for stuff that's depends on
cryptoapi.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
