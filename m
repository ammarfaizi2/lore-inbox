Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290100AbSAKUdo>; Fri, 11 Jan 2002 15:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290097AbSAKUbX>; Fri, 11 Jan 2002 15:31:23 -0500
Received: from [213.171.51.190] ([213.171.51.190]:10381 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S290101AbSAKUbJ>;
	Fri, 11 Jan 2002 15:31:09 -0500
Date: Fri, 11 Jan 2002 23:31:07 +0300
From: Nikita Gergel <fc@yauza.ru>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: {PATCH 2.5.2-pre11] ps2esdi.c 'MINOR' and 'MKDEV' cleanups
Message-Id: <20020111233107.6a08df3c.fc@yauza.ru>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__11_Jan_2002_23:31:07_+0300_083316d8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__11_Jan_2002_23:31:07_+0300_083316d8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

I've found some well known compilation bugs in ps2esdi.c.
This patch fixes them.

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom

--Multipart_Fri__11_Jan_2002_23:31:07_+0300_083316d8
Content-Type: application/octet-stream;
 name="ps2esdi.diff"
Content-Disposition: attachment;
 filename="ps2esdi.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIGxpbnV4LTIuNS4yLXByZTExL2RyaXZlcnMvYmxvY2svcHMyZXNkaS5jIGxpbnV4
LTIuNS4yLXByZTExLXBhdGNoZWQvZHJpdmVycy9ibG9jay9wczJlc2RpLmMKLS0tIGxpbnV4LTIu
NS4yLXByZTExL2RyaXZlcnMvYmxvY2svcHMyZXNkaS5jCVdlZCBEZWMgMTYgMjM6MjA6MDAgMjAw
MQorKysgbGludXgtMi41LjItcHJlMTEtcGF0Y2hlZC9kcml2ZXJzL2Jsb2NrL3BzMmVzZGkuYwlG
cmkgSmFuIDExIDIzOjExOjAyIDIwMDIKQEAgLTQ4MSw3ICs0ODEsNyBAQAogCX0KIAllbHNlIGlm
ICgoQ1VSUkVOVF9ERVYgPCBwczJlc2RpX2RyaXZlcykgJiYKIAkgICAgKENVUlJFTlQtPnNlY3Rv
ciArIENVUlJFTlQtPmN1cnJlbnRfbnJfc2VjdG9ycyA8PQotCSAgICBwczJlc2RpW01JTk9SKENV
UlJFTlQtPnJxX2RldildLm5yX3NlY3RzKSAmJgorCSAgICBwczJlc2RpW21pbm9yKENVUlJFTlQt
PnJxX2RldildLm5yX3NlY3RzKSAmJgogCSAgICAJQ1VSUkVOVC0+ZmxhZ3MgJiBSRVFfQ01EKSB7
CiAjaWYgMAogCQlwcmludGsoIiVzOmdvdCByZXF1ZXN0LiBkZXZpY2UgOiAlZCBtaW5vciA6ICVk
IGNvbW1hbmQgOiAlZCAgc2VjdG9yIDogJWxkIGNvdW50IDogJWxkXG4iLApAQCAtNTEwLDcgKzUx
MCw3IEBACiAJLyogaXMgcmVxdWVzdCBpcyB2YWxpZCAqLwogCWVsc2UgewogCQlwcmludGsoIkdy
cnIuIGVycm9yLiBwczJlc2RpX2RyaXZlczogJWQsICVsdSAlbHVcbiIsIHBzMmVzZGlfZHJpdmVz
LAotCQkgICAgICAgQ1VSUkVOVC0+c2VjdG9yLCBwczJlc2RpW01JTk9SKENVUlJFTlQtPnJxX2Rl
dildLm5yX3NlY3RzKTsKKwkJICAgICAgIENVUlJFTlQtPnNlY3RvciwgcHMyZXNkaVttaW5vcihD
VVJSRU5ULT5ycV9kZXYpXS5ucl9zZWN0cyk7CiAJCWVuZF9yZXF1ZXN0KEZBSUwpOwogCX0KIH0K
QEAgLTQyMiw3ICs0MjIsNyBAQAoJYmxrX3F1ZXVlX21heF9zZWN0b3JzKEJMS19ERUZBVUxUX1FV
RVVFKE1BSk9SX05SKSwgMTI4KTsKIAogCWZvciAoaSA9IDA7IGkgPCBwczJlc2RpX2RyaXZlczsg
aSsrKSB7Ci0JCXJlZ2lzdGVyX2Rpc2soJnBzMmVzZGlfZ2VuZGlzayxNS0RFVihNQUpPUl9OUixp
PDw2KSwxPDw2LAorCQlyZWdpc3Rlcl9kaXNrKCZwczJlc2RpX2dlbmRpc2ssbWtfa2RldihNQUpP
Ul9OUixpPDw2KSwxPDw2LAogCQkJCSZwczJlc2RpX2ZvcHMsCiAJCQkJcHMyZXNkaV9pbmZvW2ld
LmhlYWQgKiBwczJlc2RpX2luZm9baV0uc2VjdCAqCiAJCQkJcHMyZXNkaV9pbmZvW2ldLmN5bCk7
Cg==

--Multipart_Fri__11_Jan_2002_23:31:07_+0300_083316d8--
