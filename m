Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTKNHws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 02:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTKNHws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 02:52:48 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:39826 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261384AbTKNHwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 02:52:46 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Brian Beattie <beattie@beattie-home.net>
Subject: Re: serverworks usb under 2.4.22
Date: Fri, 14 Nov 2003 08:51:00 +0100
User-Agent: KMail/1.5.4
References: <1068769021.884.4.camel@kokopelli>
In-Reply-To: <1068769021.884.4.camel@kokopelli>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311140851.09228.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Brian,
hi lkml,

On Friday 14 November 2003 01:17, Brian Beattie wrote:
> I've got a system with a Super Micro P3 dual processor board.  This
> board uses the Serverworks chipset and the 2.4.22 kernel is unable to
> allocate an IRQ when initializing the USB (usb-ohic) interface.  This
> board works fine under 2.4.20 and 2.4.21.

Which Serverworks chipset? There are various.

I for one need to pass "noapic" on the kernel command line. Otherwise
the IRQ routing is broken, I can't get the USB IRQ and the kernel complains.
a lot about a broken APIC IRQ routing.

My board is an ASUS CUR-CLS. The chipset there is "ServerWorks LE".

Hop that helps.


Regards

Ingo Oeser


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/tIlrU56oYWuOrkARAsPBAKDVHqTnQHRlgB7CdMphY70GpVn3fQCdE8bQ
U4/gpKuad2q40FAPqmAeC6I=
=kUSh
-----END PGP SIGNATURE-----

