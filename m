Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVCDFBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVCDFBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVCDE6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:58:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:55687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbVCCTjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:39:54 -0500
Date: Thu, 3 Mar 2005 11:37:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Adrian Bunk <bunk@stusta.de>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <1109877336.4032.47.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> 
 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
  <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> 
 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
  <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> 
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>  <20050303170808.GG4608@stusta.de>
 <1109877336.4032.47.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Thomas Gleixner wrote:
> 
> It still does not solve the problem of "untested" releases. Users will
> still ignore the linus-tree-rcX kernels. 

.. and maybe that problem is unsolvable. People certainly argued 
vehemently that anything we do to try to make test releases (renaming etc) 
won't help.

So what do you do if you find an unsolvable problem? You don't solve it: 
you make sure it's not a show-stopper.

So part of the idea of having the "other tree" is that it ends up solving 
the "hmm, we missed that detail" problem. And by _not_ giving it release 
numbers or any schedule at all, people can't _wait_ for it. 

Sneaky. That's my middle name.

		Linus
