Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752090AbWKANIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbWKANIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWKANIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:08:18 -0500
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:43171 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752090AbWKANIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:08:17 -0500
X-BigFish: V
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: modpost warning: class mask
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 1 Nov 2006 21:06:23 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2D2BB@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: modpost warning: class mask
Thread-Index: Acb9HmvIUpfVztQ+T+6a637SyQG37QAlcz/w
From: "Conke Hu" <conke.hu@amd.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "gregkh" <greg@kroah.com>
X-OriginalArrivalTime: 01 Nov 2006 13:06:28.0450 (UTC) FILETIME=[8AFF4C20:01C6FDB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,
	It's a no harmful warning, the patch was tested on ATI IXP600 (namely SB600), it works.

Best regards,
Conke @ AMD, Inc.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Randy Dunlap
Sent: 2006Äê11ÔÂ1ÈÕ 2:47
To: linux-kernel; gregkh
Subject: modpost warning: class mask

Should we be concerned about this warning?

WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05

from drivers/ide/pci/atiixp.c:

	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID, PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},

-- 
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



