Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVCCRvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVCCRvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCCRul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:50:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262103AbVCCRtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:49:11 -0500
Date: Thu, 3 Mar 2005 09:50:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <42274171.3030702@nortel.com>
Message-ID: <Pine.LNX.4.58.0503030949040.25732@ppc970.osdl.org>
References: <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <42274171.3030702@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Chris Friesen wrote:
>
> Linus Torvalds wrote:
> 
> > I'll tell you what the problem is: I don't think you'll find anybody to do
> > the parallell "only trivial patches" tree.
> 
> Isn't this what -ac and -as effectively already are?

No. They both end up doing a lot of much fancier stuff. There are patches 
in there that I may not be comfortable with, because they end up doing 
things like totally re-doing the locking for some subsystem. 

Yes, they end up re-doing _broken_ locking, but the point is that they are 
not obvious. They are just "more careful" versions of the -mm tree.

		Linus
