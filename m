Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUGVIck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUGVIck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 04:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUGVIck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 04:32:40 -0400
Received: from bsd.ite.com.tw ([210.208.198.222]:15884 "EHLO bsd.ite.com.tw")
	by vger.kernel.org with ESMTP id S266805AbUGVIch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 04:32:37 -0400
From: Donald.Huang@ite.com.tw
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C46FC6.6B179262"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6524.0
Subject: RE: Tracking down source of wrong interrupt 2.6.7.
Date: Thu, 22 Jul 2004 16:32:26 +0800
Message-ID: <884B07FD576C3F49938D233F0E0A2B002E694D@itemail1.internal.ite.com.tw>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Tracking down source of wrong interrupt 2.6.7.
Thread-Index: AcRhBalecWMIOKMHS3yzzGRB7DlnUQOwFvnQ
To: <ian.stirling@mauve.plus.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C46FC6.6B179262
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

You may download the latest driver from ITE (

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ian Stirling
Sent: Saturday, July 03, 2004 9:55 PM
To: Linux Kernel Mailing List
Subject: Tracking down source of wrong interrupt 2.6.7.


I have an ITE raid card, which sort-of-works with my k7s5a motherboard.
Using the GPL driver from ite.
(copy at http://www.mauve.demon.co.uk/iteraid.c)

It causes massive keyboard problems, complaining about keycode 0 being =
undefined.

I suspect this is due to interrupt 1 (i8042) somehow being triggered =
every
time that 11 (it8218) is.

About 80% of the time.
Any clues about where in general I should start looking?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------_=_NextPart_001_01C46FC6.6B179262
Content-Type: application/octet-stream;
	name="Binary and Source code.url"
Content-Transfer-Encoding: base64
Content-Description: Binary and Source code.url
Content-Disposition: attachment;
	filename="Binary and Source code.url"

W0ludGVybmV0U2hvcnRjdXRdDQpVUkw9aHR0cDovL3d3dy5pdGUuY29tLnR3L3BjL0xpbnV4RHJp
dmVyX2l0ODIxMl8wOTIwMDUtMDkuemlwDQpNb2RpZmllZD0wMDBDNzM2NkM2NkZDNDAxREYNCg==

------_=_NextPart_001_01C46FC6.6B179262--
