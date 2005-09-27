Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVI0VBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVI0VBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVI0VBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:01:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:45145 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S965084AbVI0VBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:01:18 -0400
Date: Tue, 27 Sep 2005 23:01:14 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20050927210113.GA26967@harddisk-recovery.com>
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net> <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br> <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net> <Pine.LNX.4.60.0509272139220.18464@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0509272139220.18464@poirot.grange>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 09:42:44PM +0200, Guennadi Liakhovetski wrote:
> Version B here. It first had only 128MB, worked fine, I added 256MB, 
> system become unstable, memtest86 found "bad memory" around the last 
> megabytes. Then I bought 512MB, hoping to use it with 256MB - no way. 
> Every module alone works, but not together. But in my case memtest86 did 
> find errors. Try removing the 256MB module?...

FWIW, some VIA based chipsets only take a single DDR400 module, not
two. The manuals are a bit vague about it.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
