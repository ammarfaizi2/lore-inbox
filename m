Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUFPFNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUFPFNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 01:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUFPFNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 01:13:11 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:55690 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S266173AbUFPFNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 01:13:08 -0400
Date: Wed, 16 Jun 2004 00:13:05 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Claudio Martins <ctpm@ist.utl.pt>
cc: linux-kernel@vger.kernel.org, Peter Maas <fedora@rooker.dyndns.org>
Subject: Re: 3ware 9500S Drivers (mm kernel)
In-Reply-To: <200406152242.07392.ctpm@ist.utl.pt>
Message-ID: <Pine.GSO.4.21.0406160010240.12222-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudio,

> By the way, right now smartctl doesn't seem to work at all with SATA
> using the libata drivers, because AFAIK libata hasn't been taught to
> pass through the required S.M.A.R.T commands to the drive yet.

Jeff Garzik intends to add a passthru ioctl to libata, specifically for
applications like smartmontools.  As soon as he's done this, we'll add
another '-d sata' device type to utilize that ioctl().

> Does anyone know how difficult is this to code, or if it is necessary
> to change the scsi layer as well as libata? I'm willing to assist in
> testing any patches to add the possibility of using smartmontools with
> libata drivers.

I don't know the answer but suspect that the scsi layer can handle this
'as is'.  In fact the 3ware support in smartmontools passes all commands
through the scsi layer.

I appreciate the offer to act as a tester -- you'll probably hear from me
when this work is in progress, to take you up on it.

Cheers,
	Bruce

