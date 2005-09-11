Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVIKGsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVIKGsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVIKGsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:48:20 -0400
Received: from baythorne.infradead.org ([81.187.2.161]:60877 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932401AbVIKGsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:48:19 -0400
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <43237083.5070406@pobox.com>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
	 <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org>
	 <43235707.7050909@pobox.com> <200509102332.54619.s0348365@sms.ed.ac.uk>
	 <43237083.5070406@pobox.com>
Content-Type: text/plain
Date: Sun, 11 Sep 2005 07:47:45 +0100
Message-Id: <1126421265.4171.249.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-10 at 19:47 -0400, Jeff Garzik wrote:
> Presumably David Woodhouse (MTD maintainer) would yell if we just
> ripped out the in-tree users.

Not as much as I yelled when the inter_module_crap was added in the
first place. I'll be happy to see the back of it.

The code which uses it is in need of a redesign anyway, and I'd
previously said that I didn't want a patch which _only_ removes the
inter_module_crap; the warnings there were actually a real indication
that something more was needed. But at the Kernel Summit I was persuaded
otherwise -- I'd accept a minimal patch just to kill the warning.

> It is even more silly to continue compiling code that is dead for
> almost everybody.

Agreed. And even though it's deprecated, people don't _really_ stop
using it till it's dead.

-- 
dwmw2


