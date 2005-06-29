Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVF2GvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVF2GvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVF2GvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:51:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:17571 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262446AbVF2GvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:51:18 -0400
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050629063301.GA8285@iram.es>
References: <1119847159.5133.106.camel@gaston>
	 <20050628085701.GA31218@lst.de> <1120002793.5133.214.camel@gaston>
	 <20050629063301.GA8285@iram.es>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:45:31 +1000
Message-Id: <1120027531.31924.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 08:33 +0200, Gabriel Paubert wrote:
> On Wed, Jun 29, 2005 at 09:53:12AM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2005-06-28 at 10:57 +0200, Christoph Hellwig wrote:
> > > On Mon, Jun 27, 2005 at 02:39:16PM +1000, Benjamin Herrenschmidt wrote:
> > > > This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> > > > split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> > > > powerbooks have, CONFIG_PM for power management related code, and just
> > > > left out of any CONFIG_* option for some generally useful stuff that can
> > > > be used on non-laptops as well.
> > > 
> > > Can you clarify the CONFIG_PMAC_MEDIABAY for which powerbooks this
> > > is needed exactly?  AFAIK up to one of the G3 models, but you probably
> > > know better :)
> > 
> > 3400/3500 models (603 & first G3), wallstreet and 101 afaik. Mostly old
> > models with a hotswap bay containing the CD-ROM, a floppy drive or an
> > additional battery.
> 
> Actually all G3 including the Pismo (I have one) although I don't know
> if the drive bay accepts floppy drives. By the time this model was
> introduced, floppies were already on their way out.

Yup, I don't think Keylargo has a swim3 cell

> Mine was delivered with a DVD reader, which is the only part that really 
> shows problems after 4 years and a half of daily use (and it has got
> its third battery but that's in line with expected battery life).
> 
> 	Gabriel

