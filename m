Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWJNSBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWJNSBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWJNSBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:01:38 -0400
Received: from mout1.freenet.de ([194.97.50.132]:22942 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1422734AbWJNSBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:01:38 -0400
Date: Sat, 14 Oct 2006 20:03:21 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] 2.6.19-rc1-mm1 pktcdvd: init pktdev_major
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "Peter Osterlund" <petero2@telia.com>, "akpm@osdl.org" <akpm@osdl.org>
Content-Type: multipart/mixed; boundary=----------M80nfRDkTfzAUeMePek8PG
MIME-Version: 1.0
References: <op.tguqh5r2iudtyh@master> <m3k63emtma.fsf@telia.com>
Message-ID: <op.thfa3vzviudtyh@master>
In-Reply-To: <m3k63emtma.fsf@telia.com>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------M80nfRDkTfzAUeMePek8PG
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hello,

this is a bugfix for pktcdvd.c:

pktdev_major must be initialized to 0.

Signed-off-by: Thomas Maier <balagi@justmail.de>


------------M80nfRDkTfzAUeMePek8PG
Content-Disposition: attachment; filename=pktcdvd-1-init-pktdev_major.patch
Content-Type: application/octet-stream; name=pktcdvd-1-init-pktdev_major.patch
Content-Transfer-Encoding: Base64

ZGlmZiAtdXJwTiBsaW51eC0yLjYuMTktcmMxLW1tMS9kcml2ZXJzL2Jsb2NrL3Br
dGNkdmQuYyAxLWluaXQtcGt0ZGV2X21ham9yL2RyaXZlcnMvYmxvY2svcGt0Y2R2
ZC5jCi0tLSBsaW51eC0yLjYuMTktcmMxLW1tMS9kcml2ZXJzL2Jsb2NrL3BrdGNk
dmQuYwkyMDA2LTEwLTE0IDEzOjQ2OjA0LjAwMDAwMDAwMCArMDIwMAorKysgMS1p
bml0LXBrdGRldl9tYWpvci9kcml2ZXJzL2Jsb2NrL3BrdGNkdmQuYwkyMDA2LTEw
LTE0IDEzOjUwOjU0LjAwMDAwMDAwMCArMDIwMApAQCAtODMsNyArODMsNyBAQAog
CiBzdGF0aWMgc3RydWN0IHBrdGNkdmRfZGV2aWNlICpwa3RfZGV2c1tNQVhfV1JJ
VEVSU107CiBzdGF0aWMgc3RydWN0IHByb2NfZGlyX2VudHJ5ICpwa3RfcHJvYzsK
LXN0YXRpYyBpbnQgcGt0ZGV2X21ham9yOworc3RhdGljIGludCBwa3RkZXZfbWFq
b3IgPSAwOwogc3RhdGljIHN0cnVjdCBtdXRleCBjdGxfbXV0ZXg7CS8qIFNlcmlh
bGl6ZSBvcGVuL2Nsb3NlL3NldHVwL3RlYXJkb3duICovCiBzdGF0aWMgbWVtcG9v
bF90ICpwc2RfcG9vbDsKIAo=

------------M80nfRDkTfzAUeMePek8PG--

