Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUL0DPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUL0DPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 22:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUL0DPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 22:15:32 -0500
Received: from bsd.ite.com.tw ([210.208.198.222]:51972 "EHLO bsd.ite.com.tw")
	by vger.kernel.org with ESMTP id S261744AbUL0DP0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 22:15:26 -0500
From: Donald.Huang@ite.com.tw
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] it8212.c, kernel 2.6.9-ac16
X-MimeOLE: Produced By Microsoft Exchange V6.0.6524.0
Date: Mon, 27 Dec 2004 11:16:49 +0800
Message-ID: <884B07FD576C3F49938D233F0E0A2B002FA6FE@itemail1.internal.ite.com.tw>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] it8212.c, kernel 2.6.9-ac16
Thread-Index: AcTmrXosAlc4DhqSQUeUYe/IWBtraAFE+pmg
To: <alan@lxorguk.ukuu.org.uk>, <fippu@fippu.ch>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IT8211 and IT8212 are the same , if you use it as a normal IDE device.
But IT8212 has a hardware raid fuction.
The first IT8211's product ID ,maybe also use IT8212's product ID.
I think it's ok to use the IT8212 driver.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Monday, December 20, 2004 10:56 PM
To: Philipp E, Imhof
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] it8212.c, kernel 2.6.9-ac16


On Gwe, 2004-12-17 at 14:01, Philipp E, Imhof wrote:
> I do not know whether the 8212 and the 8211 are fully
> compatible, but in my computer, 8211 works fine with 8212's
> driver.

Reading the datasheet I believe they are except that for IT8211 we
should not be checking for smart mode perhaps ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
