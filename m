Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbSKFSmM>; Wed, 6 Nov 2002 13:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265979AbSKFSmM>; Wed, 6 Nov 2002 13:42:12 -0500
Received: from fmr02.intel.com ([192.55.52.25]:11517 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265972AbSKFSmL>; Wed, 6 Nov 2002 13:42:11 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4C5@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Stelian Pop'" <stelian.pop@fr.alcove.com>,
       Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.20-pre10-ac2, Sony PCG-C1MHP and Sonypi
Date: Wed, 6 Nov 2002 10:48:41 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stelian Pop [mailto:stelian.pop@fr.alcove.com] 
> On Wed, Nov 06, 2002 at 10:15:51AM +0100, Manuel Serrano wrote:
> 
> > > > > Sonypi and USB modules seems to be incompatible. That 
> is, if I don't load
> [...]
> > Well,
> > 
> > first of all this things is driving me nuts ;-) I have compiled and
> > tested at least 10 variations around the kernel and ACPI and I have
> > noticed about 10 different behaviors.
> [...]
> > My intuition (which may be totally erroneous) is that there 
> is something
> > broken in the ospm_ec support. I explain this:
> [...]
> 
> You should really send a CC: of this on the acpi mailing list:
> 	https://lists.sourceforge.net/lists/listinfo/acpi-devel

Can you reproduce with 2.5.latest?

Also, yeah we need a patch to list the keyboard as only using 0x60 and 0x62,
not the whole range.

Regards -- Andy
