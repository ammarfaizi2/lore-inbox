Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUFZDcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUFZDcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 23:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266930AbUFZDcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 23:32:13 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:44808 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265996AbUFZDbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 23:31:40 -0400
Message-ID: <1088212304.40dccd5035660@vds.kolivas.org>
Date: Sat, 26 Jun 2004 11:11:44 +1000
From: kernel@kolivas.org
To: Michael Buesch <mbuesch@freenet.de>
Cc: Willy Tarreau <willy@w.ods.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de> <20040625190533.GI29808@alpha.home.local> <200406252148.37606.mbuesch@freenet.de>
In-Reply-To: <200406252148.37606.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ10882123034bc83167d86d0f855f880c74e10124f6"
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ10882123034bc83167d86d0f855f880c74e10124f6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Quoting Michael Buesch <mbuesch@freenet.de>:
> But as the load grows, the system is usable as with load 0.0.
> And it really should be usable with 76.0% nice. ;) No problem here.
> This really high load is not correct.

There was the one clear bug that Adrian Drzewiecki found (thanks!) that is easy
to fix. Can you see if this has any effect before I go searching elsewhere?

Con

---MOQ10882123034bc83167d86d0f855f880c74e10124f6
Content-Type: application/octet-stream; name="staircase7.4-1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="staircase7.4-1"

LS0tIGxpbnV4LTIuNi43L2tlcm5lbC9zY2hlZC5jCTIwMDQtMDYtMjYgMTM6Mjc6NDcuNjAxNDA5
MDYyICsxMDAwCisrKyBsaW51eC0yLjYuNy1jazIva2VybmVsL3NjaGVkLmMJMjAwNC0wNi0yNiAx
MzowODowNy4wMDAwMDAwMDAgKzEwMDAKQEAgLTIzMSw4ICsyMzEsOCBAQCBzdGF0aWMgdm9pZCBk
ZXF1ZXVlX3Rhc2soc3RydWN0IHRhc2tfc3RyCiAKIHN0YXRpYyB2b2lkIGVucXVldWVfdGFzayhz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHJ1bnF1ZXVlX3QgKnJxKQogewotCWlmIChycS0+Y3Vyci0+
ZmxhZ3MgJiBQRl9QUkVFTVBURUQpIHsKLQkJcnEtPmN1cnItPmZsYWdzICY9IH5QRl9QUkVFTVBU
RUQ7CisJaWYgKHAtPmZsYWdzICYgUEZfUFJFRU1QVEVEKSB7CisJCXAtPmZsYWdzICY9IH5QRl9Q
UkVFTVBURUQ7CiAJCWxpc3RfYWRkKCZwLT5ydW5fbGlzdCwgcnEtPnF1ZXVlICsgcC0+cHJpbyk7
CiAJfSBlbHNlCiAJCWxpc3RfYWRkX3RhaWwoJnAtPnJ1bl9saXN0LCBycS0+cXVldWUgKyBwLT5w
cmlvKTsK

---MOQ10882123034bc83167d86d0f855f880c74e10124f6--
