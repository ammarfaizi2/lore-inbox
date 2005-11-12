Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVKLQXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVKLQXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 11:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVKLQXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 11:23:36 -0500
Received: from atlantis.8hz.com ([212.129.237.78]:63954 "EHLO atlantis.8hz.com")
	by vger.kernel.org with ESMTP id S932410AbVKLQXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 11:23:36 -0500
Date: Sat, 12 Nov 2005 17:23:34 +0100
From: Sean Young <sean@mess.org>
To: Josh Boyer <jwboyer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1 [PATCH] MTD_TS5500 Kconfig
Message-ID: <20051112162334.GA25600@atlantis.8hz.com>
References: <20051112141929.GA25124@atlantis.8hz.com> <625fc13d0511120703s3d84f5e1h57862b50847bf7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0511120703s3d84f5e1h57862b50847bf7e1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 09:03:15AM -0600, Josh Boyer wrote:
> On 11/12/05, Sean Young <sean@mess.org> wrote:
> > CONFIG_ELAN does not exist any more.
> >
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> > diff -uprN a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> > --- a/drivers/mtd/maps/Kconfig  2005-11-12 13:52:48.000000000 +0100
> > +++ b/drivers/mtd/maps/Kconfig  2005-11-12 13:52:02.000000000 +0100
> > @@ -94,7 +94,7 @@ config MTD_NETSC520
> >
> >  config MTD_TS5500
> >         tristate "JEDEC Flash device mapped on Technologic Systems TS-5500"
> > -       depends on ELAN
> > +       depends on X86
> >         select MTD_PARTITIONS
> >         select MTD_JEDECPROBE
> >         select MTD_CFI_AMDSTD
> > -
> 
> Could you send this to the MTD mailing list?

It's already in MTD cvs. Should this go through the mtd git tree?


Sean
