Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUCEJGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCEJGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:06:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:62153 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262263AbUCEJG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:06:28 -0500
Subject: Re: [PATCH] For test only: pmac_zilog fixes (cups lockup at boot):
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Matthias Urlichs <smurf@smurf.noris.de>,
       =?ISO-8859-1?Q?Martin-=C9ric?= Racine <q-funk@pp.fishpool.fi>
In-Reply-To: <20040305085838.B22156@flint.arm.linux.org.uk>
References: <1078473270.5703.57.camel@gaston>
	 <20040305085838.B22156@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1078477504.5700.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 20:05:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 19:58, Russell King wrote:
> On Fri, Mar 05, 2004 at 06:54:31PM +1100, Benjamin Herrenschmidt wrote:
> > Ok, so I finally got a hand on the problems. A mix of bugs in
> > the driver, bugs in the HW, and bugs in the TTY layer ! pfiew.
> 
> I'm not even going to bother reviewing these changes - the gratuitous
> change of "up" to "uap" makes this task virtually impossible.

Oh... and the change wasn't gratuitous... "up" do actually conflict
with up() as soon as you try to use a semaphore :)

Ben.


