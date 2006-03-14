Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWCNQSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWCNQSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWCNQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:18:34 -0500
Received: from mail0.lsil.com ([147.145.40.20]:27531 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751199AbWCNQSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:18:33 -0500
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C64782.EADDADA2"
Subject: RE: [PATCH ] drivers/scsi/scsi.c - export reprobe 
Date: Tue, 14 Mar 2006 09:18:23 -0700
Message-ID: <F331B95B72AFFB4B87467BE1C8E9CF5F36D939@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH ] drivers/scsi/scsi.c - export reprobe 
Thread-Index: AcZHAZpp/wvGNY9KRWmb/AwqfyYfIwAgTCOw
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Moore, Eric" <Eric.Moore@lsil.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: <James.Bottomley@SteelEye.com>, <hch@lst.de>, <gregkh@novell.com>
X-OriginalArrivalTime: 14 Mar 2006 16:18:24.0031 (UTC) FILETIME=[EAFB82F0:01C64782]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C64782.EADDADA2
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On  Monday, March 13, 2006 5:53 PM, Eric Moore wrote:

>=20
> ---------------------------------------------------
> Adding support for exposing hidden raid components=20
> for sg interface. The sdev->no_uld_attach flag
> will set set accordingly.
>=20
> The sas module supports adding/removing raid
> volumes using online storage management application
> interface. =20
>=20
> This patch was provided to me by Christoph Hellwig.
>=20
> Signed-off-by: Eric Moore <Eric.Moore@lsil.com>


Here is repost of patch due to dos line endings.

------_=_NextPart_001_01C64782.EADDADA2
Content-Type: application/octet-stream;
	name="scsi_device_reprobe"
Content-Transfer-Encoding: base64
Content-Description: scsi_device_reprobe
Content-Disposition: attachment;
	filename="scsi_device_reprobe"

SW5kZXg6IHNjc2ktbWlzYy0yLjYvZHJpdmVycy9zY3NpL3Njc2kuYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IHNjc2ktbWlzYy0yLjYub3JpZy9kcml2ZXJzL3Njc2kvc2NzaS5jCTIwMDYtMDMtMDQgMTM6MDc6
NDQuMDAwMDAwMDAwICswMTAwDQorKysgc2NzaS1taXNjLTIuNi9kcml2ZXJzL3Njc2kvc2NzaS5j
CTIwMDYtMDMtMDcgMjE6NTc6MjEuMDAwMDAwMDAwICswMTAwDQpAQCAtMTIxNCw2ICsxMjE0LDEz
IEBADQogfQ0KIEVYUE9SVF9TWU1CT0woc2NzaV9kZXZpY2VfY2FuY2VsKTsNCiANCit2b2lkIHNj
c2lfZGV2aWNlX3JlcHJvYmUoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2KQ0KK3sNCisJZGV2aWNl
X3JlcHJvYmUoJnNkZXYtPnNkZXZfZ2VuZGV2KTsNCit9DQorDQorRVhQT1JUX1NZTUJPTChzY3Np
X2RldmljZV9yZXByb2JlKTsNCisNCiBNT0RVTEVfREVTQ1JJUFRJT04oIlNDU0kgY29yZSIpOw0K
IE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCiANCkluZGV4OiBzY3NpLW1pc2MtMi42L2luY2x1ZGUv
c2NzaS9zY3NpX2RldmljZS5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gc2NzaS1taXNjLTIuNi5vcmlnL2lu
Y2x1ZGUvc2NzaS9zY3NpX2RldmljZS5oCTIwMDYtMDMtMDQgMTM6MDc6NDkuMDAwMDAwMDAwICsw
MTAwDQorKysgc2NzaS1taXNjLTIuNi9pbmNsdWRlL3Njc2kvc2NzaV9kZXZpY2UuaAkyMDA2LTAz
LTA3IDIxOjU3OjQ1LjAwMDAwMDAwMCArMDEwMA0KQEAgLTIwNCw2ICsyMDQsNyBAQA0KIAkJCSAg
IHVpbnQgdGFyZ2V0LCB1aW50IGx1bik7DQogZXh0ZXJuIHZvaWQgc2NzaV9yZW1vdmVfZGV2aWNl
KHN0cnVjdCBzY3NpX2RldmljZSAqKTsNCiBleHRlcm4gaW50IHNjc2lfZGV2aWNlX2NhbmNlbChz
dHJ1Y3Qgc2NzaV9kZXZpY2UgKiwgaW50KTsNCitleHRlcm4gdm9pZCBzY3NpX2RldmljZV9yZXBy
b2JlKHN0cnVjdCBzY3NpX2RldmljZSAqKTsNCiANCiBleHRlcm4gaW50IHNjc2lfZGV2aWNlX2dl
dChzdHJ1Y3Qgc2NzaV9kZXZpY2UgKik7DQogZXh0ZXJuIHZvaWQgc2NzaV9kZXZpY2VfcHV0KHN0
cnVjdCBzY3NpX2RldmljZSAqKTsNCg==

------_=_NextPart_001_01C64782.EADDADA2--
