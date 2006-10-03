Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWJCP0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWJCP0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWJCPZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:25:57 -0400
Received: from mout0.freenet.de ([194.97.50.131]:23276 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1030205AbWJCPZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:25:47 -0400
Date: Tue, 03 Oct 2006 17:26:50 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] 2.6.18-mm3 pktcdvd: module parameters
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "petero2@telia.com" <petero2@telia.com>, "akpm@osdl.org" <akpm@osdl.org>
Content-Type: multipart/mixed; boundary=----------jyqUw4mRUnDhDbDVNroLKP
MIME-Version: 1.0
Message-ID: <op.tguqi00riudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------jyqUw4mRUnDhDbDVNroLKP
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hello,

this patch exports some module parameters:

pktdev_major                 device major
write_congestion_on          on/off marks of bio write congestion control
write_congestion_off
packet_buffers               number of packet buffers per device

http://people.freenet.de/BalaGi/download/pktcdvd-10-module-params_2.6.18.patch

Signed-off-by: Thomas Maier<balagi@justmail.de>

-Thomas Maier

------------jyqUw4mRUnDhDbDVNroLKP
Content-Disposition: attachment; filename=pktcdvd-10-module-params_2.6.18.patch
Content-Type: application/octet-stream; name=pktcdvd-10-module-params_2.6.18.patch
Content-Transfer-Encoding: Base64

ZGlmZiAtdXJwTiA5LXBhY2tldC1idWZmZXJzL2RyaXZlcnMvYmxvY2svcGt0Y2R2
ZC5jIDEwLW1vZHVsZS1wYXJhbXMvZHJpdmVycy9ibG9jay9wa3RjZHZkLmMKLS0t
IDktcGFja2V0LWJ1ZmZlcnMvZHJpdmVycy9ibG9jay9wa3RjZHZkLmMJMjAwNi0x
MC0wMyAxMzo1NDo1NC4wMDAwMDAwMDAgKzAyMDAKKysrIDEwLW1vZHVsZS1wYXJh
bXMvZHJpdmVycy9ibG9jay9wa3RjZHZkLmMJMjAwNi0xMC0wMyAxMzo1NToxNC4w
MDAwMDAwMDAgKzAyMDAKQEAgLTg2LDExICs4NiwxMyBAQAogCiAjZGVmaW5lIFpP
TkUoc2VjdG9yLCBwZCkgKCgoc2VjdG9yKSArIChwZCktPm9mZnNldCkgJiB+KChw
ZCktPnNldHRpbmdzLnNpemUgLSAxKSkKIAotc3RhdGljIHN0cnVjdCBwa3RjZHZk
X2RldmljZSAqcGt0X2RldnNbTUFYX1dSSVRFUlNdOworLyogbW9kdWxlIHBhcmFt
ZXRlcnMgKi8KIHN0YXRpYyBpbnQgcGt0ZGV2X21ham9yID0gMDsgLyogZGVmYXVs
dDogZHluYW1pYyBtYWpvciBudW1iZXIgKi8KIHN0YXRpYyBpbnQgd3JpdGVfY29u
Z2VzdGlvbl9vbiAgPSBQS1RfV1JJVEVfQ09OR0VTVElPTl9PTjsKIHN0YXRpYyBp
bnQgd3JpdGVfY29uZ2VzdGlvbl9vZmYgPSBQS1RfV1JJVEVfQ09OR0VTVElPTl9P
RkY7CiBzdGF0aWMgaW50IHBhY2tldF9idWZmZXJzID0gUEtUX0JVRkZFUlNfREVG
QVVMVDsKKworc3RhdGljIHN0cnVjdCBwa3RjZHZkX2RldmljZSAqcGt0X2RldnNb
TUFYX1dSSVRFUlNdOwogc3RhdGljIHN0cnVjdCBtdXRleCBjdGxfbXV0ZXg7CS8q
IFNlcmlhbGl6ZSBvcGVuL2Nsb3NlL3NldHVwL3RlYXJkb3duICovCiBzdGF0aWMg
bWVtcG9vbF90ICpwc2RfcG9vbDsKIApAQCAtMzI3NywzICszMjc5LDggQEAgTU9E
VUxFX0xJQ0VOU0UoIkdQTCIpOwogCiBtb2R1bGVfaW5pdChwa3RfaW5pdCk7CiBt
b2R1bGVfZXhpdChwa3RfZXhpdCk7CisKK21vZHVsZV9wYXJhbShwa3RkZXZfbWFq
b3IsIGludCwgMCk7Cittb2R1bGVfcGFyYW0od3JpdGVfY29uZ2VzdGlvbl9vbiwg
aW50LCAwKTsKK21vZHVsZV9wYXJhbSh3cml0ZV9jb25nZXN0aW9uX29mZiwgaW50
LCAwKTsKK21vZHVsZV9wYXJhbShwYWNrZXRfYnVmZmVycywgaW50LCAwKTsK
------------jyqUw4mRUnDhDbDVNroLKP--

