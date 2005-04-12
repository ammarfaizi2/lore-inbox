Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVDLQ44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVDLQ44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVDLQzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:55:02 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:54071 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262411AbVDLQyC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:54:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 11:54:04 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F12215B@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/evjIhKVpGsOhT1qgs66fXTG7cQAA7C2A
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> What features?  Didn't we end up with a valid resolution to all of the
> additional stuff in the jsm driver that you originally asked for?  Why
> not work on adding those new features to the serial core, and then
there
> would be no issue with accepting your other driver?

I appreciate your "calm" response. =)

DPA (Digi Port Authority) support (the special ioctls)
and /proc (and /sys) files were left unresolved.
Wendy had no choice but to remove them to get the driver
into the kernel sources.

IBM was okay with removing them, so I was okay with doing it as well,
as the whole point of the JSM driver is to support IBM's card directly.

However, removing those things are just unacceptable for Digi for our
cards.

I understand your position, and I respect it.
This is why for now, I cannot submit the original DGNC driver.

However, I have taken your suggestion of moving to the serial-core to
heart,
and in the future, when I am able to drop 2.4 kernel support in the
DGNC driver, I will completely go to serial-core, like the JSM driver
has already done.

Thanks!
Scott Kilau

