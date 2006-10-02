Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWJBVQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWJBVQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWJBVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:16:40 -0400
Received: from www.osadl.org ([213.239.205.134]:31171 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932524AbWJBVQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:16:39 -0400
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
	passing to IRQ handlers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dtor@mail.ru,
       greg@kroah.com, david-b@pacbell.net, stern@rowland.harvard.edu
In-Reply-To: <20061002.141209.21618299.davem@davemloft.net>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002201836.GB31365@elte.hu>
	 <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
	 <20061002.141209.21618299.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 23:18:44 +0200
Message-Id: <1159823924.1386.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 14:12 -0700, David Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Mon, 2 Oct 2006 13:54:33 -0700 (PDT)
> 
> > So if the patch works against my current tree, and nobody objects, I can 
> > certainly apply it.
> > 
> > So speak up, people...
> 
> Since it provides a suitable nestability of the regs setting, I have
> no objections.

ACK

	tglx


