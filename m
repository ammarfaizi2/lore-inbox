Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTFKMUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTFKMUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:20:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32170
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264376AbTFKMUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:20:44 -0400
Subject: Re: PROBLEM: Kernel Panic Promise driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sydow@speakeasy.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306101829120.18252-300000@web0.speakeasy.net>
References: <Pine.LNX.4.44.0306101829120.18252-300000@web0.speakeasy.net>
Content-Type: multipart/mixed; boundary="=-H2LVDTYK7jUlgIJM3z5l"
Organization: 
Message-Id: <1055334718.2084.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 13:32:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H2LVDTYK7jUlgIJM3z5l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mer, 2003-06-11 at 02:32, sydow@speakeasy.net wrote:
> The output of those commands are attached. Sorry it took me awhile. My 
> system drive gave up the ghost, and I just got it back up. Thanks for the 
> fast response.

Thanks. Try this



--=-H2LVDTYK7jUlgIJM3z5l
Content-Disposition: attachment; filename=a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=a1; charset=UTF-8

--- drivers/ide/pci/pdc202xx_new.h~	2003-06-11 13:30:45.000000000 +0100
+++ drivers/ide/pci/pdc202xx_new.h	2003-06-11 13:30:45.000000000 +0100
@@ -255,7 +255,7 @@
 		.vendor		=3D PCI_VENDOR_ID_PROMISE,
 		.device		=3D PCI_DEVICE_ID_PROMISE_20275,
 		.name		=3D "PDC20275",
-		.init_setup	=3D init_setup_pdcnew,
+		.init_setup	=3D init_setup_pdc20276,
 		.init_chipset	=3D init_chipset_pdcnew,
 		.init_iops	=3D NULL,
 		.init_hwif	=3D init_hwif_pdc202new,

--=-H2LVDTYK7jUlgIJM3z5l--
