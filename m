Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbTB1QWh>; Fri, 28 Feb 2003 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268009AbTB1QWh>; Fri, 28 Feb 2003 11:22:37 -0500
Received: from havoc.daloft.com ([64.213.145.173]:62389 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268006AbTB1QWh>;
	Fri, 28 Feb 2003 11:22:37 -0500
Date: Fri, 28 Feb 2003 11:32:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI request/release generic address
Message-ID: <20030228163253.GB6351@gtf.org>
References: <3E5F8DA5.9050804@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5F8DA5.9050804@acm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 10:26:13AM -0600, Corey Minyard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Is there a way in the ACPI code to do a request/release of I/O or memory
> with an acpi_generic_address?  Does it even make sense to do this?
> There are generic I/O routines for using a generic address, and I'm
> working with an ACPI table that has a generic address, so it would seem
> to make sense to have memory reservation routines through this, too.

Can you define a generic address?

IIRC, ACPI needs some work in this area.

If the "generic address" is host RAM, that's easy.
If the generic address is PIO address, that's mostly easy.
If the generic address is MMIO address, that takes a bit of care with
mapping, and I'm not sure ACPI gets it right in these cases.

	Jeff




