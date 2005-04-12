Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVDLPGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVDLPGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVDLPBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:01:50 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:24586 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262403AbVDLOzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:55:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 09:55:10 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F038FBB@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/bhmnmMKV8WtsQyWlEbrQZz9bswAAAzZQ
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (Digi) cares.

We want people to use our DGNC driver over the JSM driver in all
cases except the 2 port model of the board.

This is because the DGNC driver contains extra features that the JSM
driver
Has stripped out, to get into the kernel sources,
and our other customers WANT these features!

We cannot have a situation where the JSM driver takes control of the PCI
card
before the DGNC driver can take it first!

Please, do *NOT* add this patch!!!

Do I, as a copyright holder on the code in question, have any rights at
all,
or are you just going to trample over my wishes, in your zeal?

Scott








-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Tuesday, April 12, 2005 9:44 AM
To: Kilau, Scott
Cc: Ihalainen Nickolay; admin@list.net.ru; linux-kernel@vger.kernel.org
Subject: Re: Digi Neo 8: linux-2.6.12_r2 jsm driver


On Tue, Apr 12, 2005 at 09:02:42AM -0500, Kilau, Scott wrote:
> LKML, please, do *NOT* apply this patch to the kernel!
> It will cause conflicts if our customers have both the Digi DGNC and
> IBM/Digi JSM drivers installed!

Who cares?  If you're driver was written properly (which I hope for you)
it'll just skip a device that's bound to the jsm driver already.

And having additional hardware support is always a good thing,
especially
if it's as trivial as that patch.
