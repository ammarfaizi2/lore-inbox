Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319478AbSIMB1I>; Thu, 12 Sep 2002 21:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319479AbSIMB1H>; Thu, 12 Sep 2002 21:27:07 -0400
Received: from dp.samba.org ([66.70.73.150]:3023 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319478AbSIMB1H>;
	Thu, 12 Sep 2002 21:27:07 -0400
Date: Fri, 13 Sep 2002 11:31:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Martin Schwenke <martin@meltin.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Pull NFS server address off root_server_path
Message-ID: <20020913013153.GP32156@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Martin Schwenke <martin@meltin.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, trond.myklebust@fys.uio.no,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
References: <200209120208.MAA00777@thucydides.inspired.net.au> <1031818177.2994.39.camel@irongate.swansea.linux.org.uk> <200209130032.KAA32528@thucydides.inspired.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209130032.KAA32528@thucydides.inspired.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 10:28:29AM +1000, Martin Schwenke wrote:
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
>     Alan> You are probably much better using the initrd based dhcp
>     Alan> client from things like the LTSP project (ltsp.org) than the
>     Alan> kernel one
> 
> That's probably true in the long term.  For the short term, is the
> initrd-based stuff working right now?  I didn't think it was quite
> there yet...

Well, initrd works (as opposed to the still-in-progress initramfs),
but setting up an image to do the DHCP, NFS mount and pivot_root is a
pain in the bum.  LTSP is all i386 (afaict), which helps me not at
all.

> If the patch goes in now, I won't be terribly disappointed if it comes
> back out, along with (most of) the rest of the ipconfig stuff, if the
> initrd-based stuff works acceptably before the feature freeze...
> 
> I would think that if there's a chance that the ipconfig stuff will
> stay in for 2.6, and this patch improves it, then it should probably
> be merged.  The patch has been in use at OzLabs for about 6 months
> (since I moved the DHCP server off the NFS server :-) to help boot the
> embedded boxes that David Gibson is doing bring-up work on.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
