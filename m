Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266621AbUGQGk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUGQGk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 02:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266639AbUGQGk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 02:40:26 -0400
Received: from fmr02.intel.com ([192.55.52.25]:62155 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S266621AbUGQGkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 02:40:19 -0400
Subject: Re: 2.6.7-mm[3-4] doesn't boot (alsa or pnp related) (fixed - Acpi)
From: Len Brown <len.brown@intel.com>
To: szonyi calin <caszonyi@yahoo.com>
Cc: Calin Szonyi <caszonyi@rdslink.ro>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFFA6@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFFA6@hdsmsx403.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1090046355.2792.12.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Jul 2004 02:39:15 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2004-07-12 at 16:35, szonyi calin wrote:
> --- szonyi calin <caszonyi@yahoo.com> a écrit : > ---
> caszonyi@rdslink.ro a écrit : > Hi all
> > > I just tried today 2.6.7-mm3 and 2.6.7-mm4.
> > > They both stop booting at:
> > > Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun
> > > May 30
> > > 10:49:40 2004 UTC)
> > > pnp: Device 01:01.00 activated
> > > pnp: Device 01:01.02 activated
> > > pnp: Device 01:01.03 activated
> > > 
> > 
> > The same happens on 2.6.7-mm5 ;-(
> 
> ... and with 2.6.7-mm6 and 2.6.8-rc1
> Booting with acpi=off fixes the problem. ;-)

Did a previous kernel work w/o acpi=off?
If yes, please send me the dmesg and /proc/interrupts
for both the working and failing kernels.

thanks,
-Len


