Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVBID7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVBID7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 22:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVBID7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 22:59:12 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:6833 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261774AbVBID7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 22:59:03 -0500
Date: Wed, 9 Feb 2005 03:58:37 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt>
References: <20050204103350.241a907a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="17432832-283338140-1107921517=:7433"
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--17432832-283338140-1107921517=:7433
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 4 Feb 2005, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/

Andrew,

Please add to -mm the patch in attachment, since it solves the old
acpi_power_off bug...

Best Regards,
Marcos Marado

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFCCYpxmNlq8m+oD34RAsJQAKDmBDtuPseiQkpSfZfiiCG05xDoOwCfZvKc
sQje5ivpItBbcTYqTP1gKvU=
=90/h
-----END PGP SIGNATURE-----

--17432832-283338140-1107921517=:7433
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="acpi_power_off_prepare.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="acpi_power_off_prepare.patch"

ZGlmZiAtTnJ1IC1wMSBsaW51eC0yLjYuMTEtcmMyLW1tMS9kcml2ZXJzL2Fj
cGkvc2xlZXAvcG93ZXJvZmYuYyBsaW51eC0yLjYuMTEtcmMyLW1tMS1tYm4x
L2RyaXZlcnMvYWNwaS9zbGVlcC9wb3dlcm9mZi5jDQotLS0gbGludXgtMi42
LjExLXJjMi1tbTEvZHJpdmVycy9hY3BpL3NsZWVwL3Bvd2Vyb2ZmLmMJMjAw
NC0xMi0yNCAyMjozNTozOS4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0y
LjYuMTEtcmMyLW1tMS1tYm4xL2RyaXZlcnMvYWNwaS9zbGVlcC9wb3dlcm9m
Zi5jCTIwMDUtMDEtMjYgMDA6MjU6MDQuMDAwMDAwMDAwICswMTAwDQpAQCAt
OSwyICs5LDMgQEANCiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KKyNpbmNs
dWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8YWNwaS9hY3BpX2J1
cy5oPg0KQEAgLTEzLDIgKzE0LDIwIEBADQogDQorc3RhdGljIHZvaWQgDQor
YWNwaV9wb3dlcl9vZmZfcHJlcGFyZSh2b2lkKQ0KK3sNCisgICAgICAgaWYg
KHN5c3RlbV9zdGF0ZSA9PSBTWVNURU1fUE9XRVJfT0ZGKSB7DQorICAgICAg
ICAgICAgICAgYWNwaV93YWtldXBfZ3BlX3Bvd2Vyb2ZmX3ByZXBhcmUoKTsN
CisgICAgICAgICAgICAgICBhY3BpX2VudGVyX3NsZWVwX3N0YXRlX3ByZXAo
QUNQSV9TVEFURV9TNSk7DQorICAgICAgIH0NCit9DQorDQordm9pZCANCitk
b19hY3BpX3Bvd2VyX29mZl9wcmVwYXJlKHZvaWQpDQorew0KKyAgICAgICBp
ZiAoIWFjcGlfZGlzYWJsZWQpIHsNCisgICAgICAgICAgICAgICBhY3BpX3Bv
d2VyX29mZl9wcmVwYXJlKCk7DQorICAgICAgIH0NCit9DQorCQkJDQorDQog
c3RhdGljIHZvaWQNCkBAIC0xNyw2ICszNiw2IEBAIGFjcGlfcG93ZXJfb2Zm
ICh2b2lkKQ0KIAlwcmludGsoIiVzIGNhbGxlZFxuIixfX0ZVTkNUSU9OX18p
Ow0KKyNpZiAwCS8qIFRoaXMgc2hvdWxkIGJlIG1hZGUgcmVkdW5kYW50IGJ5
IG90aGVyIHBhdGNoZXMuLiAqLw0KIAkvKiBTb21lIFNNUCBtYWNoaW5lcyBv
bmx5IGNhbiBwb3dlcm9mZiBpbiBib290IENQVSAqLw0KIAlzZXRfY3B1c19h
bGxvd2VkKGN1cnJlbnQsIGNwdW1hc2tfb2ZfY3B1KDApKTsNCi0JYWNwaV93
YWtldXBfZ3BlX3Bvd2Vyb2ZmX3ByZXBhcmUoKTsNCi0JYWNwaV9lbnRlcl9z
bGVlcF9zdGF0ZV9wcmVwKEFDUElfU1RBVEVfUzUpOw0KKyNlbmRpZg0KIAlB
Q1BJX0RJU0FCTEVfSVJRUygpOw0KZGlmZiAtTnJ1IC1wMSBsaW51eC0yLjYu
MTEtcmMyLW1tMS9kcml2ZXJzL2Jhc2UvcG93ZXIvc2h1dGRvd24uYyBsaW51
eC0yLjYuMTEtcmMyLW1tMS1tYm4xL2RyaXZlcnMvYmFzZS9wb3dlci9zaHV0
ZG93bi5jDQotLS0gbGludXgtMi42LjExLXJjMi1tbTEvZHJpdmVycy9iYXNl
L3Bvd2VyL3NodXRkb3duLmMJMjAwNC0xMi0yNCAyMjozNTowMS4wMDAwMDAw
MDAgKzAxMDANCisrKyBsaW51eC0yLjYuMTEtcmMyLW1tMS1tYm4xL2RyaXZl
cnMvYmFzZS9wb3dlci9zaHV0ZG93bi5jCTIwMDUtMDEtMjYgMDA6MjY6NTQu
MDAwMDAwMDAwICswMTAwDQpAQCAtNjQsMiArNjQsOSBAQCB2b2lkIGRldmlj
ZV9zaHV0ZG93bih2b2lkKQ0KIA0KKyNpZiAxDQorCXsNCisJCWV4dGVybiB2
b2lkIGRvX2FjcGlfcG93ZXJfb2ZmX3ByZXBhcmUodm9pZCk7DQorCQlkb19h
Y3BpX3Bvd2VyX29mZl9wcmVwYXJlKCk7DQorCX0NCisjZW5kaWYNCisJDQog
CXN5c2Rldl9zaHV0ZG93bigpOw0K

--17432832-283338140-1107921517=:7433--
