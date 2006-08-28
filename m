Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWH1T0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWH1T0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWH1T0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:26:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750754AbWH1T0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:26:31 -0400
Date: Mon, 28 Aug 2006 12:25:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Jeff Garzik <jeff@garzik.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@osdl.org,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-Id: <20060828122535.911e593a.akpm@osdl.org>
In-Reply-To: <20060828171926.GB25491@mellanox.co.il>
References: <20060828154242.GB30105@elf.ucw.cz>
	<20060828171926.GB25491@mellanox.co.il>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 20:19:26 +0300
"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:

> Quoting r. Pavel Machek <pavel@ucw.cz>:
> > Subject: Re: T60 not coming out of suspend to RAM
> > 
> > On Mon 2006-08-28 16:53:58, Michael S. Tsirkin wrote:
> > > OK, it turns out the problem was with running SATA drive in AHCI mode.
> > > 
> > > After applying the following patch from Forrest Zhao
> > > http://lkml.org/lkml/2006/7/20/56
> > > both suspend to disk and suspend to ram work fine now.
> > > This patch is going into 2.6.18, isn't it?
> > 
> > Not sure, check latest -rc5, and if it is not there, ask akpm...
> > 
> 
> Andrew, this is going into 2.6.18, isn't it? I don't see it in -rc5.
> 

It looks like Forrest's stuff is all queued up in the libata devel tree,
although in a significantly different-looking form.

So no, right now it doesn't look good for 2.6.18.
