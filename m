Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUCWJuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUCWJuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:50:17 -0500
Received: from math.ut.ee ([193.40.5.125]:33180 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262412AbUCWJuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:50:12 -0500
Date: Tue, 23 Mar 2004 11:50:04 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Adam Belay <ambx1@neo.rr.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PnPBIOS: Unknown tag '0x82'
In-Reply-To: <20040322160252.GA6414@neo.rr.com>
Message-ID: <Pine.GSO.4.44.0403231149120.18934-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PnPBIOS: Scanning system for PnP BIOS support...
> > PnPBIOS: Found PnP BIOS installation structure at 0xc00f2480
> > PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x1d2a, dseg 0xf0000
> > pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
> > pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
> > PnPBIOS: Unknown tag '0x82', length '18': 82 12 00 49 6e 74 65 6c 20 46 69 72 6d 77 61 72 65 20 .
> > pnp: 00:0b: ioport range 0x800-0x87f has been reserved
> > PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
>
> In this case it should be harmless.  Typically when one tag is
> corrupted (or incorrectly interpreted) it will also complain
> about the following tag because of size checks.  Where did the
> unknown tag occur?  Perhaps in pnpbios_parse_resource_option_data?

It's in pnpbios_parse_compatible_ids.

-- 
Meelis Roos (mroos@linux.ee)

