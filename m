Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUGFQ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUGFQ1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUGFQ1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:27:20 -0400
Received: from fmr11.intel.com ([192.55.52.31]:15232 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264113AbUGFQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:27:19 -0400
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
From: Len Brown <len.brown@intel.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1089130549.3160.2.camel@paragon.slim>
References: <A6974D8E5F98D511BB910002A50A6647615FEF3E@hdsmsx403.hd.intel.com>
	 <1089054167.15653.51.camel@dhcppc4>  <1089058581.2496.9.camel@paragon.slim>
	 <1089059612.3589.5.camel@paragon.slim> <1089062128.15675.122.camel@dhcppc4>
	 <1089130549.3160.2.camel@paragon.slim>
Content-Type: text/plain
Organization: 
Message-Id: <1089131222.15660.445.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Jul 2004 12:27:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 12:15, Jurgen Kramer wrote:
> On Mon, 2004-07-05 at 23:15, Len Brown wrote:
> > On Mon, 2004-07-05 at 16:33, Jurgen Kramer wrote:
> > > On Mon, 2004-07-05 at 22:16, Jurgen Kramer wrote:

> > > 2.6.7 vanilly results are in. The results are...it works..
> > 
> > great!  Now if you can apply this patch to 2.6.7 and tell me if
> > it is ACPI that broke EHCI for you in -mm5 or something else:
> > 
> >
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/broken-out/bk-acpi.patch
> > 
> Alright, still looks good:

> <snip>
> 
> So it doesn't look like a ACPI problem.

Okay, something else in -mm5 broke your ehci.
Now -mm6 is out, probably that is the thing to try next.

thanks,
-Len


