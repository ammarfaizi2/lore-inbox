Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVDLUpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVDLUpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVDLUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:44:56 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:12174 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262947AbVDLUVN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:21:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 15:21:15 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F122163@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/hWb0WMGkL8hIQ2Kjb5wuXljm2QAFrk2Q
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

> Ok, but wasn't it possible to get those additional things added to the
> main kernel serial core, which would then provide everything that
Digi's
> customers are accustomed to?

Yes, it is my intention in the future to add support for the needed
information,
probably at the /sys level.
The key is to be able to get at the tty information without
having to open up the tty/port.

Again, I understand why you required the changes in JSM,
IBM didn't need DPA support, so I had no problem with removing the
support.

However, neither IBM nor Digi wants this thread's patch to be applied,
and yet Christoph wants to do it, completely out of spite, to break our
out-of-tree open source driver.

This is the problem that I have.

Scott
