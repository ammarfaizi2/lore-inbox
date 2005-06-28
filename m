Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVF2ADz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVF2ADz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVF2ADq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:03:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:2719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262327AbVF1X6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:58:44 -0400
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050628085701.GA31218@lst.de>
References: <1119847159.5133.106.camel@gaston>
	 <20050628085701.GA31218@lst.de>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 09:53:12 +1000
Message-Id: <1120002793.5133.214.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 10:57 +0200, Christoph Hellwig wrote:
> On Mon, Jun 27, 2005 at 02:39:16PM +1000, Benjamin Herrenschmidt wrote:
> > This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> > split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> > powerbooks have, CONFIG_PM for power management related code, and just
> > left out of any CONFIG_* option for some generally useful stuff that can
> > be used on non-laptops as well.
> 
> Can you clarify the CONFIG_PMAC_MEDIABAY for which powerbooks this
> is needed exactly?  AFAIK up to one of the G3 models, but you probably
> know better :)

3400/3500 models (603 & first G3), wallstreet and 101 afaik. Mostly old
models with a hotswap bay containing the CD-ROM, a floppy drive or an
additional battery.

Ben.


