Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVD3Fu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVD3Fu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 01:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVD3Fu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 01:50:26 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:32460 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262519AbVD3FuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 01:50:19 -0400
Date: Sat, 30 Apr 2005 08:52:31 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO
 etc.
In-Reply-To: <20050429203805.GA2959@kroah.com>
Message-ID: <Pine.LNX.4.61.0504300849350.21122@kai.makisara.local>
References: <20050427171446.GA3195@kroah.com> <20050427171649.GG3195@kroah.com>
 <1114619928.18809.118.camel@localhost.localdomain>
 <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
 <1114694511.18809.187.camel@localhost.localdomain> <20050429042014.GC25474@kroah.com>
 <1114805784.18330.297.camel@localhost.localdomain> <20050429203805.GA2959@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Greg KH wrote:

> On Fri, Apr 29, 2005 at 09:16:27PM +0100, Alan Cox wrote:
> > On Gwe, 2005-04-29 at 05:20, Greg KH wrote:
> > > > Ok thats the bit I needed to know
> > > 
> > > So, do you still object to this patch being accepted?
> > 
> > Switched to CAP_SYS_RAWIO I don't. Its the wrong answer long term I
> > suspect but its definitely a good answer for now.
> 
> Switch it in both capable() calls in the patch?  Kai, is this acceptable
> to you also?
> 
Yes. Using CAP_SYS_ADMIN here was wrong.

-- 
Kai
