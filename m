Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSDDOLA>; Thu, 4 Apr 2002 09:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSDDOKu>; Thu, 4 Apr 2002 09:10:50 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:27628 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313184AbSDDOKo>; Thu, 4 Apr 2002 09:10:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 4 Apr 2002 06:10:36 -0800
Message-Id: <200204041410.GAA02032@adam.yggdrasil.com>
To: linux-usb-devel@lists.sourceforge.net
Subject: linux-2.5.8-pre1/drivers/usb/uhci.o locks up hard
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have not analyzed this problem fully and it's not particularly
urgent, but I thought I ought to report it just to make it part of
the knowledge base.

	linux-2.5.8-pre1/drivers/usb/uhci.o locks up hard after printing
"hub.c: 2 ports detected" on both my Sony Picturebook PCG-C1VN (Transmeta)
and a Pentium 3 desktop machine with a VIA chipset.  Oddly, uhci.o seems
to be fine on my older Kapok 1100m Pentium 2 notebook.  I believe uhci.o
gave me null pointer dereferences or something similar on my Picturebook
under 2.5.7 also.

	usb-uhci seems to be fine on all of these machines, although I have
not tried doing anything with a USB device other than looking at the
device ID information.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
