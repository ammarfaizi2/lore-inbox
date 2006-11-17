Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933749AbWKQRwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933749AbWKQRwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933750AbWKQRwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:52:44 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:21144 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S933749AbWKQRwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:52:43 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Fri, 17 Nov 2006 09:42:06 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907218@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ALSA: hda-intel - Disable MSI support by default
Thread-Index: AccKZo9fjm91zKORQRiSwimRZF+gNgACMIGA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Linus Torvalds" <torvalds@osdl.org>
cc: "Takashi Iwai" <tiwai@suse.de>, "Olivier Nicolas" <olivn@trollprod.org>,
       "Jeff Garzik" <jeff@garzik.org>, "David Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 17 Nov 2006 17:42:07.0363 (UTC)
 FILETIME=[B3912530:01C70A6F]
X-WSS-ID: 69432BE40T0676213-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 

>Eventually, MSI will hopefully be the more robust of the two methods. 
>Maybe it will take a year. And maybe we'll end up not using MSI on a
lot 
>of the _current_ crop of motherboards. We don't want to carry the "fall

>back from MSI to INTx" code around. We just want a flag saying "use
MSI" 
>or "use INTx".

Good, that will be simple and clear.

YH


