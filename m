Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUBUAX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUBUAX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:23:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261451AbUBUAXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:23:21 -0500
Date: Fri, 20 Feb 2004 16:23:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Fix silly thinko in sungem network driver.
Message-Id: <20040220162318.097006ee.davem@redhat.com>
In-Reply-To: <1077322322.9623.34.camel@gaston>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	<1077321849.9719.32.camel@gaston>
	<1077322322.9623.34.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 11:12:03 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2004-02-21 at 11:04, Benjamin Herrenschmidt wrote:
> > On Sat, 2004-02-21 at 09:29, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1584, 2004/02/20 14:29:11-08:00, torvalds@ppc970.osdl.org
> > > 
> > > 	Fix silly thinko in sungem network driver.
> > > 	
> > 
> > Argh. Actually, the patch is wrong as we are losing the 2 other
> > magic bits (the RonPaul bit, dunno what it is, that's how it's
> > called by Apple, end the other bugfix bit, some more apple magic).
> > 
> > Fixed patch on its way ... (as soon as I finish pulling, don't
> > cancel that cset, I'll apply a patch on top of it)
> 
> Here it is:

I thought the idea was that if IBURST doesn't stick, then the Apple specific
bits aren't implemented?

That's what the comment says.
