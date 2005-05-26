Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVEZE1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVEZE1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVEZE1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:27:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:40936 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261192AbVEZE1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:27:50 -0400
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org>
References: <1117080454.9076.25.camel@gaston>
	 <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:27:12 +1000
Message-Id: <1117081633.9076.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 21:25 -0700, Linus Torvalds wrote:
> 
> On Thu, 26 May 2005, Benjamin Herrenschmidt wrote:
> > 
> > If it's ok with you, I'll send a patch doing it later today.
> 
> It's ok by me, certainly. There aren't that many users, and it sounds
> sane. I'll just prefer the patch going through Greg..

Ok, just wanted some feedback from you. Some people prefer that I whack
some "token" in the vitual address at map time, or that I compare the
vaddr at unmap time with all PCI busses IO ranges or that sort of ugly
thing, it sounds to me simpler to just pass along the bar number, but I
wanted your and Greg's ack first.

Ben.


