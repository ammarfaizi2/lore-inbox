Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVCCVYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVCCVYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCCVPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:15:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44461 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262398AbVCCVHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:07:32 -0500
Message-ID: <42277C81.4010302@pobox.com>
Date: Thu, 03 Mar 2005 16:07:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>	 <20050303170808.GG4608@stusta.de>	 <1109877336.4032.47.camel@tglx.tec.linutronix.de>	 <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>	 <42276AF5.3080603@pobox.com> <1109882043.4032.79.camel@tglx.tec.linutronix.de>
In-Reply-To: <1109882043.4032.79.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a further elaboration...

The problem with the current 2.6-rc setup is a _human_ _communications_ 
problem.

Users have been trained in a metaphor that is applied uniformly across 
all software projects that use the metaphor:

	test release:		a useful merge/testing point
	release candidate:	bugfixes only, test test test

Linux does it differently.

It's hard enough to get users to test...   now we have raised the 
barrier even higher by abusing a common metaphor.  A metaphor that is 
used _succesfully_ elsewhere to get users to test.

"release candidate" is a promise to users that the current tree is close 
to what the release will look like, and only major fixes will appear 
between -rc and -final.

We broke that promise.  In human interface terms, this is like 
redefining the "garbage can" icon to mean "save your work."  ;-)

	Jeff



