Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVCCR7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVCCR7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVCCRy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:54:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:64960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbVCCRwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:52:19 -0500
Date: Thu, 3 Mar 2005 09:53:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050303170336.GL19505@suse.de>
Message-ID: <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303165533.GQ28536@shell0.pdx.osdl.net>
 <20050303170336.GL19505@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Jens Axboe wrote:
> 
> Why should there be one? One of the things I like about this concept is
> that it's just a moving tree. There could be daily snapshots like the
> -bkX "releases" of Linus's tree, if there are changes from the day
> before. It means (hopefully) that no one will "wait for x.y.z.2 because
> that is really stable".

Exactly. Th ewhole point of this tree is that there shouldn't be anything 
questionable in it. All the patches are independent, and they are all 
trivial and small.

Which is not to say there couldn't be regressions even from trivial and 
small patches, and yes, there will be an outcry when there is, but we're 
talking minimizing the risk, not making it impossible.

		Linus
