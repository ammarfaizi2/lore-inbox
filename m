Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266039AbUA1XKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUA1XKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:10:49 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:1299 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266039AbUA1XKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:10:44 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3E5F3.EC1125E5"
Subject: RE: [PATCH] cpqarray update
Date: Wed, 28 Jan 2004 17:10:29 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E1596D@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update
Thread-Index: AcPlyULQ4MIveEp0R4mOuZHFEET44QAKaziQ
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Greg KH" <greg@kroah.com>, "Hollis Blanchard" <hollisb@us.ibm.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Jan 2004 23:10:30.0781 (UTC) FILETIME=[ECB822D0:01C3E5F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3E5F3.EC1125E5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Ok. Here's the patch for that. At least until vio_module_init comes :)

thanks
-francis-



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]=20
> Sent: Wednesday, January 28, 2004 11:41 AM
> To: Hollis Blanchard
> Cc: Jeff Garzik; Linux Kernel Mailing List; Wiran, Francis
> Subject: Re: [PATCH] cpqarray update
>=20
>...
> Well, changing it back to pci_register_driver() and actually checking
> the return value would be a good idea :)
>=20
> thanks,
>=20
> greg k-h
>=20

------_=_NextPart_001_01C3E5F3.EC1125E5
Content-Type: application/octet-stream;
	name="cpqarray_pci_unregister.patch"
Content-Transfer-Encoding: base64
Content-Description: cpqarray_pci_unregister.patch
Content-Disposition: attachment;
	filename="cpqarray_pci_unregister.patch"

CiAgICogQ2hlY2tzIHRoZSByYyBvZiBwY2lfcmVnaXN0ZXJfZHJpdmVyIGFuZCB1bnJlZ2lzdGVy
IHdoZW4gbmVjZXNzYXJ5CgoKIGRyaXZlcnMvYmxvY2svY3BxYXJyYXkuYyB8ICAgIDMgKystCiAx
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGxpbnV4
LTIuNC4yNC9kcml2ZXJzL2Jsb2NrL2NwcWFycmF5LmN+Y3BxYXJyYXlfcGNpX3VucmVnaXN0ZXIJ
V2VkIEphbiAyOCAxNjo1NjozOSAyMDA0CisrKyBsaW51eC0yLjQuMjQtcm9vdC9kcml2ZXJzL2Js
b2NrL2NwcWFycmF5LmMJV2VkIEphbiAyOCAxNzowMToxMCAyMDA0CkBAIC02MjMsNyArNjIzLDgg
QEAgaW50IF9faW5pdCBjcHFhcnJheV9pbml0KHZvaWQpCiAKIAkvKiBkZXRlY3QgY29udHJvbGxl
cnMgKi8KIAlwcmludGsoRFJJVkVSX05BTUUgIlxuIik7Ci0JcGNpX3JlZ2lzdGVyX2RyaXZlcigm
Y3BxYXJyYXlfcGNpX2RyaXZlcik7CisJaWYgKCFwY2lfcmVnaXN0ZXJfZHJpdmVyKCZjcHFhcnJh
eV9wY2lfZHJpdmVyKSkKKwkJcGNpX3VucmVnaXN0ZXJfZHJpdmVyKCZjcHFhcnJheV9wY2lfZHJp
dmVyKTsKIAljcHFhcnJheV9laXNhX2RldGVjdCgpOwogCiAJZm9yKGk9MDsgaTwgTUFYX0NUTFI7
IGkrKykgewoKXwo=

------_=_NextPart_001_01C3E5F3.EC1125E5--
