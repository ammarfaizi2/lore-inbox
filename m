Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVCCUaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVCCUaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVCCU1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:27:02 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:55722
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262127AbVCCUXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:23:55 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <422768B4.3040506@pobox.com>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <20050303170808.GG4608@stusta.de>
	 <1109877336.4032.47.camel@tglx.tec.linutronix.de>
	 <422768B4.3040506@pobox.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 21:23:52 +0100
Message-Id: <1109881432.4032.69.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 14:42 -0500, Jeff Garzik wrote:
> 1) Release maintainers need to avoid merging non-bugfixes.  Lately, the 
> key penguins _have_ been doing their job here.  This manifested in 
> 2.6.11-rc4, 2.6.11-rc5.

True, but the confidence of users in -rc is gone already. So testing
happens when the "stable" release is out, but thats too late.

> 2) This "flag day" when bugfixes-only mode starts needs to be completely 
> obvious to _scripts_ and really dumb people.  Posting to LKML "with this 
> -rc, I am only taking serious bugfixes" doesn't cut it.  There must be a 
> clear, consistent point where testing may begin.

If you clearly seperate out the -rc process of the development tree then
it is no question how dump scripts and people are. The -rc tree is
untouchable for anything else than bugfixes.

tglx


