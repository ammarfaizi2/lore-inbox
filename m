Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWGQB2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGQB2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 21:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGQB2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 21:28:31 -0400
Received: from [216.208.38.107] ([216.208.38.107]:53638 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932116AbWGQB2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 21:28:30 -0400
Subject: Re: 2.6.18 Headers - Long
From: Arjan van de Ven <arjan@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, dwmw2@infradead.org,
       maillist@jg555.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
In-Reply-To: <787b0d920607161222o55cd8837g6545bfd00e50d452@mail.gmail.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
	 <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
	 <787b0d920607161138l4b6dc25dycaeaaea5e948c769@mail.gmail.com>
	 <20060716185314.GA17172@flint.arm.linux.org.uk>
	 <787b0d920607161222o55cd8837g6545bfd00e50d452@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 03:26:18 +0200
Message-Id: <1153099599.3150.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 15:22 -0400, Albert Cahalan wrote:
> On 7/16/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Sun, Jul 16, 2006 at 02:38:45PM -0400, Albert Cahalan wrote:
> > > On 7/16/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > > >On Jul 15, 2006, at 17:09:28, Albert Cahalan wrote:
> > >
> > > >You realize that on a couple architectures it's fundamentally
> > > >impossible to get atomic ops completely in userspace, right?
> > >
> > > Sure. Those architectures don't need to drag down the rest.
> > > Plenty of headers are only exported for some architectures.
> >
> > Wrong perspective.  The problem is that they may _appear_ to work as
> > described, but not actually work in the intended way.  That's a bug,
> > and it's a _hard_ bug to locate.
> 
> Again:
> 
> Plenty of headers are only exported for some architectures.


and guess what... atomic.h does not work on i386, at least it doesn't
provide atomic access in userspace!



