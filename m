Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTKBEFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 23:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTKBEFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 23:05:48 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:48590 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261406AbTKBEFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 23:05:47 -0500
Date: Sat, 1 Nov 2003 20:05:44 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: Matthew Wilcox <willy@debian.org>
Cc: linux-ia64@linuxia64.org, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
In-Reply-To: <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.58.0311011945190.18996@sue>
References: <Pine.GSO.4.58.0310251706470.15711@inky>
 <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Matthew Wilcox wrote:

> > I found the Kconfig logic for ACPI and IA64, as defined in arch/ia64/Kconfig and
> > drivers/acpi/Kconfig to be a bit redundant and hard to follow.  It appears to do
> > the following:
>
> I posted a similar patch here:
>
> http://marc.theaimsgroup.com/?l=linux-ia64&m=106555019402117&w=2

I do not read linux-ia64 regularly, so I did not notice your work.  I apologize
for not acknowledging it.

Why not include drivers/Kconfig and scrap the individual subdirectory includes,
as i386 does?

Also, it looks like your patch makes ACPI non-mandatory.  Is that intentional?

Thanks,
Noah

