Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVI0Vo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVI0Vo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVI0Vo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:44:59 -0400
Received: from pop.gmx.net ([213.165.64.20]:64725 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965160AbVI0Vo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:44:58 -0400
X-Authenticated: #20450766
Date: Tue, 27 Sep 2005 23:44:17 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Grzegorz Kulewski <kangur@polcom.net>,
       =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
In-Reply-To: <20050927210113.GA26967@harddisk-recovery.com>
Message-ID: <Pine.LNX.4.60.0509272342410.24945@poirot.grange>
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net>
 <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br>
 <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
 <Pine.LNX.4.60.0509272139220.18464@poirot.grange> <20050927210113.GA26967@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Erik Mouw wrote:

> On Tue, Sep 27, 2005 at 09:42:44PM +0200, Guennadi Liakhovetski wrote:
> > Version B here. It first had only 128MB, worked fine, I added 256MB, 
> > system become unstable, memtest86 found "bad memory" around the last 
> > megabytes. Then I bought 512MB, hoping to use it with 256MB - no way. 
> > Every module alone works, but not together. But in my case memtest86 did 
> > find errors. Try removing the 256MB module?...
> 
> FWIW, some VIA based chipsets only take a single DDR400 module, not
> two. The manuals are a bit vague about it.

My manual says "2". And it's a A7VI-VM, so, unfortunately, no DDR400, just 
PC133/VC133.

Thanks
Guennadi
---
Guennadi Liakhovetski
