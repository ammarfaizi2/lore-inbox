Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUDNTPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUDNTPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:15:08 -0400
Received: from fmr06.intel.com ([134.134.136.7]:20423 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261232AbUDNTPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:15:01 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C42254.AFFC2592"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Non-Exec stack patches
Date: Wed, 14 Apr 2004 12:14:19 -0700
Message-ID: <9AB83E4717F13F419BD880F5254709E5011EBABD@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Non-Exec stack patches
Thread-Index: AcQiBG6Ryvq82QXHQlK0xH5s+V3GgAAT7RxQ
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Kurt Garloff" <garloff@suse.de>,
       <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-OriginalArrivalTime: 14 Apr 2004 19:14:20.0672 (UTC) FILETIME=[B07BD800:01C42254]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C42254.AFFC2592
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Jamie Lokier wrote:
> Siddha, Suresh B wrote:
> > > If so, you want to change __P110 as well as __P111.
> >=20
> > No. Only EXEC bit is the difference.
>=20
> Yes.  __P110 means WRITE+EXEC.  __P111 means READ+WRITE+EXEC.
>=20

Thanks Jamie. Attached the updated patch. Andrew please apply.

thanks,
suresh


------_=_NextPart_001_01C42254.AFFC2592
Content-Type: application/octet-stream;
	name="noexec-ia64.fix"
Content-Transfer-Encoding: base64
Content-Description: noexec-ia64.fix
Content-Disposition: attachment;
	filename="noexec-ia64.fix"

LS0tIGxpbnV4LTI2NW1tNS9pbmNsdWRlL2FzbS1pYTY0L3BndGFibGUuaH4JMjAwNC0wNC0xNCAw
MDowOTowNC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTI2NW1tNS9pbmNsdWRlL2FzbS1pYTY0
L3BndGFibGUuaAkyMDA0LTA0LTE0IDExOjIxOjA5LjAwMDAwMDAwMCAtMDcwMApAQCAtMTQ3LDgg
KzE0Nyw4IEBACiAjZGVmaW5lIF9fUDAxMQlQQUdFX1JFQURPTkxZCS8qIGRpdHRvICovCiAjZGVm
aW5lIF9fUDEwMAlfX3BncHJvdChfX0FDQ0VTU19CSVRTIHwgX1BBR0VfUExfMyB8IF9QQUdFX0FS
X1hfUlgpCiAjZGVmaW5lIF9fUDEwMQlfX3BncHJvdChfX0FDQ0VTU19CSVRTIHwgX1BBR0VfUExf
MyB8IF9QQUdFX0FSX1JYKQotI2RlZmluZSBfX1AxMTAJUEFHRV9DT1BZCi0jZGVmaW5lIF9fUDEx
MQlQQUdFX0NPUFkKKyNkZWZpbmUgX19QMTEwCVBBR0VfQ09QWV9FWEVDCisjZGVmaW5lIF9fUDEx
MQlQQUdFX0NPUFlfRVhFQwogCiAjZGVmaW5lIF9fUzAwMAlQQUdFX05PTkUKICNkZWZpbmUgX19T
MDAxCVBBR0VfUkVBRE9OTFkK

------_=_NextPart_001_01C42254.AFFC2592--
