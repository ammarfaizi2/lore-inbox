Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVCDAKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVCDAKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVCDAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:09:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50135 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262734AbVCCXxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:53:46 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Chris Friesen <cfriesen@nortel.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303165940.GA11144@kroah.com>
References: <42268749.4010504@pobox.com>
	 <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
	 <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <42274171.3030702@nortel.com>  <20050303165940.GA11144@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109893901.21780.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Mar 2005 23:51:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-03 at 16:59, Greg KH wrote:
> On Thu, Mar 03, 2005 at 10:55:13AM -0600, Chris Friesen wrote:
> > Linus Torvalds wrote:
> > 
> > >I'll tell you what the problem is: I don't think you'll find anybody to do
> > >the parallell "only trivial patches" tree.
> > 
> > Isn't this what -ac and -as effectively already are?
> 
> Based on the patches in those trees, no :)

I've not found a much smaller set that isn't rootable, trivially DoSable
with published tools or leaves users with non-working hardware that got
pulled by Linus having a random pissy fit about pwc etc.

-ac is essentially base security fixes + working IDE locking + pwc +
fixes for the bugs everyone hit that needed fixing urgently. I consider
working locking on my storage essential because I like my data to still
be there.

-as is similar although it makes different choices about what matters.

Given 3 or 4 people it ought to be possible to make a much much tighter
patch set for this purpose.

