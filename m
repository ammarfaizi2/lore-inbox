Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWEWOzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWEWOzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWEWOzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:55:53 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:17651 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751349AbWEWOzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:55:52 -0400
Date: Tue, 23 May 2006 16:55:50 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Herman Elfrink <herman.elfrink@ti-wmc.nl>
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
Message-ID: <20060523145549.GA22749@harddisk-recovery.com>
References: <44731733.7000204@ti-wmc.nl> <1148395738.25255.68.camel@localhost.localdomain> <44731F2C.2010109@ti-wmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44731F2C.2010109@ti-wmc.nl>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 04:41:48PM +0200, Simon Oosthoek wrote:
> Alan Cox wrote:
> >On Maw, 2006-05-23 at 16:07 +0200, Herman Elfrink wrote:
> >>FLAME uses an unofficial protocol number (0x4040), any tips on how to 
> >>get an official IANA number would be highly appreciated.
> >>
> >
> >Ethernet protocol number I assume you mean. If so this at least used to
> >be handled by the IEEE, along with ethernet mac address ranges.
> >
> 
> Yes ethernet protocol (it's below IP level), I didn't realise that IEEE 
> also handled the portnumbers. I'll check the ieee website to see how it 
> works, tnx!

IEEE doesn't handle port numbers. Port numbers are for whatever is
layered on top of ethernet, so you need to register those with the
appropriate authorities (IANA for IP).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
