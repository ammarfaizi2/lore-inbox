Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUBOHtX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUBOHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:49:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:41373 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264313AbUBOHtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:49:22 -0500
Subject: Re: 2.6.3-rc3: twice defined symbols with new radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040215074106.GQ1308@fs.tum.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <20040215074106.GQ1308@fs.tum.de>
Content-Type: text/plain
Message-Id: <1076831240.6960.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:47:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 18:41, Adrian Bunk wrote:
> On Sat, Feb 14, 2004 at 07:33:45PM -0800, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.6.3-rc2 to v2.6.3-rc3
> > ============================================
> >...
> > Benjamin Herrenschmidt:
> >...
> >   o New radeonfb
> >...
> 
> I'm getting the following compile error (no module support in the 
> kernel):

Yes, you can't build both old and new radeonfb's at the same time,
I should do some Kconfig stuff to check that I beleive. It make
no sense as you don't know which one will pick up anyway.

Ben.


