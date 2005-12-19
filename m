Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVLSMT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVLSMT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 07:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVLSMT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 07:19:26 -0500
Received: from [202.125.80.34] ([202.125.80.34]:4147 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932449AbVLSMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 07:19:26 -0500
Subject: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C60496.0051A416"
Date: Mon, 19 Dec 2005 17:45:52 +0530
Content-class: urn:content-classes:message
Message-ID: <3AEC1E10243A314391FE9C01CD65429B223248@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Thread-Index: AcYElfROgLuVWoqrST6rWHOIBf0rSg==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60496.0051A416
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Dear Kernel Developers,

I have a requirement of getting the CMOS details at the user level. I =
have identified the interfaces as /dev/nvram & /dev/rtc.
But, the complete CMOS details are available to the user Applications as =
the driver does not provide the suitable interface to get the complete =
CMOS details.

I found an application that reads directly form the port 70, 71 and gets =
the complete details about the CMOS. It does not use any Device =
Interface and at the same disables all the interruptson the HOST system.

I would like to hear from you whether this kind of Applications can be =
used or NOT? Please see the attached source code I am planning to use to =
access the CMOS contents.

Please give me ur valuable suggestions.=20

Regards,
Mukund Jampala

 =20

 <<dmpCmos.c>>=20

------_=_NextPart_001_01C60496.0051A416
Content-Type: application/octet-stream;
	name="dmpCmos.c"
Content-Transfer-Encoding: base64
Content-Description: dmpCmos.c
Content-Disposition: attachment;
	filename="dmpCmos.c"

DQoNCi8qDQoqIDA0ODYgNTIzMDU5MyA1MjMyNzE3IA0KKiAgICAgICAgICAgICAgICAgICAgIENN
T1MgRFVNUEVSDQoqICAgICAgICAgIEVuZHJhemluZSBlbmRyYXppbmVAcHVsbHRoZXBsdWcub3Jn
DQoqDQoqDQoqIGNvbXBpbGluZyA6IGdjYyBjbW9zZC5jIC1vIGNtb3NkLm8NCiogdXNhZ2UgOiAj
Y21vc2QgPiBjbW9zLmR1bXANCioNCiovDQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUg
PHVuaXN0ZC5oPg0KI2luY2x1ZGUgPGFzbS9pby5oPg0KDQoNCmludCBtYWluICgpDQp7DQogICAg
ICAgIGludCBpOw0KDQogICAgICAgIGlmIChpb3Blcm0oMHg3MCwgMiwgMSkpICAgLy9Bc2sgUGVy
bWlzc2lvbiAoc2V0IHRvIDEpIA0KICAgICAgICB7ICAgICAgICAgICAgICAgICAgICAgICAgIC8v
Zm9yIHBvcnRzIDB4NzAgYW5kIDB4NzENCiAgICAgICAgICAgICAgICBwZXJyb3IoImlvcGVybSIp
Ow0KICAgICAgICAgICAgICAgIGV4aXQgKDEpOw0KICAgICAgICB9DQoNCiAgICAgICAgZm9yIChp
PTA7aTwxMjg7aSsrKQ0KICAgICAgICB7DQogICAgICAgICAgb3V0YihpLDB4NzApOy8vIFdyaXRl
IHRvIHBvcnQgMHg3MA0KICAgICAgICAgIHVzbGVlcCgxMDAwMDApOw0KICAgICAgICAgIHByaW50
ZigiJWMiLGluYigweDcxKSk7DQoNCiAgICAgICAgfQ0KDQogICAgICAgIGlmIChpb3Blcm0oMHg3
MSwgMiwgMCkpIC8vIFdlIGRvbid0IG5lZWQgUGVybWlzc2lvbiBhbnltb3JlDQogICAgICAgIHsg
ICAgICAgICAgICAgICAgICAgICAgICAvLyAoc2V0IHBlcm1pc3Npb25zIHRvIDApLg0KICAgICAg
ICAgICAgICAgICBwZXJyb3IoImlvcGVybSIpOw0KICAgICAgICAgICAgICAgICBleGl0KDEpOw0K
ICAgICAgICB9DQoNCiAgICAgICAgZXhpdCAoMCk7Ly8gUXVpdA0KfQ==

------_=_NextPart_001_01C60496.0051A416--
