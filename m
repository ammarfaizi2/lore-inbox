Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVCCUEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVCCUEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCCUAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:00:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52138
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262039AbVCCT6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:58:37 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <20050303170808.GG4608@stusta.de>
	 <1109877336.4032.47.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 20:58:33 +0100
Message-Id: <1109879913.4032.64.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 11:37 -0800, Linus Torvalds wrote:
> > It still does not solve the problem of "untested" releases. Users will
> > still ignore the linus-tree-rcX kernels. 
> 
> .. and maybe that problem is unsolvable. People certainly argued 
> vehemently that anything we do to try to make test releases (renaming etc) 
> won't help.

It wont help, if you keep it in the development line. If you move it out
of the development line into the "other tree" then it is likely to be
accepted as _real_ release candidates which get a proper testing
coverage before declaring it stable release nr. XYZ.

Users _are_ scared off by the current release quality. Your model is
ignoring this part of the problem and just provides a pacifier gimmick.

> So part of the idea of having the "other tree" is that it ends up solving 
> the "hmm, we missed that detail" problem. And by _not_ giving it release 
> numbers or any schedule at all, people can't _wait_ for it. 

After the _stable_ release, of course no schedule and release numbers
are necessary. The proposed scheme will work nicely.

> Sneaky. That's my middle name.
> 
> 		Linus

People are clever enough to debunk sneaky gimmicks.

tglx


