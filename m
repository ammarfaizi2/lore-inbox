Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUC0FAS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 00:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUC0FAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 00:00:18 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:8405 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261605AbUC0FAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 00:00:12 -0500
Date: Fri, 26 Mar 2004 23:54:59 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PnPBIOS: Unknown tag '0x82'
Message-ID: <20040326235459.GC3213@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Meelis Roos <mroos@linux.ee>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20040324162942.GA16164@neo.rr.com> <Pine.GSO.4.44.0403251316210.6391-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403251316210.6391-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 01:19:53PM +0200, Meelis Roos wrote:
> > Could you please try this patch.
>
> It works, thanks!

Great.  I'll submit this with my next set of changes.

>
> dmesg now reports
>
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f2480
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x1d2a, dseg 0xf0000
> pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
> pnp: 00:0b: ioport range 0x800-0x87f has been reserved
> PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
>
> I don't have the previous output of lspnp at hand but now it reports
> among other things
>
> 0a INT0800 memory controller: flash
>     flags: [no disable] [no config] [static]
>     allocated resources:
>         mem 0xffb00000-0xffbfffff [32 bit] [r/o]
>     possible resources:
>     compatible devices:
>         identifier 'Intel Firmware Hub'
>
> This might be it showing up.

Yes, I think it's the same tag.

Thanks,
Adam
