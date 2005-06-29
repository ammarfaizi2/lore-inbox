Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVF2Gdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVF2Gdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVF2Gdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:33:35 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:27846 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id S262198AbVF2Gd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:33:28 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 29 Jun 2005 08:33:01 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
Message-ID: <20050629063301.GA8285@iram.es>
References: <1119847159.5133.106.camel@gaston> <20050628085701.GA31218@lst.de> <1120002793.5133.214.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120002793.5133.214.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 09:53:12AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2005-06-28 at 10:57 +0200, Christoph Hellwig wrote:
> > On Mon, Jun 27, 2005 at 02:39:16PM +1000, Benjamin Herrenschmidt wrote:
> > > This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> > > split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> > > powerbooks have, CONFIG_PM for power management related code, and just
> > > left out of any CONFIG_* option for some generally useful stuff that can
> > > be used on non-laptops as well.
> > 
> > Can you clarify the CONFIG_PMAC_MEDIABAY for which powerbooks this
> > is needed exactly?  AFAIK up to one of the G3 models, but you probably
> > know better :)
> 
> 3400/3500 models (603 & first G3), wallstreet and 101 afaik. Mostly old
> models with a hotswap bay containing the CD-ROM, a floppy drive or an
> additional battery.

Actually all G3 including the Pismo (I have one) although I don't know
if the drive bay accepts floppy drives. By the time this model was
introduced, floppies were already on their way out.

Mine was delivered with a DVD reader, which is the only part that really 
shows problems after 4 years and a half of daily use (and it has got
its third battery but that's in line with expected battery life).

	Gabriel
