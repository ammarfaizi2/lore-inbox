Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTLQEuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 23:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTLQEuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 23:50:37 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:55680 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263378AbTLQEud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 23:50:33 -0500
From: "Will L G" <diskman@kc.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: pam_debug.o: gp-relative relocation against dynamic symbol _pam_token_returns
Date: Tue, 16 Dec 2003 22:50:13 -0600
Message-ID: <001e01c3c459$49a66180$6401a8c0@zephyr>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C3C426.FF0BF180"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C3C426.FF0BF180
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

When ever I attempt to compile Linux-Pam, I receive the following error
immediately after running 'make':

/usr/bin/ld: dynamic/pam_debug.o: gp-relative relocation against dynamic
symbol _pam_token_returns
/usr/bin/ld: dynamic/pam_debug.o: gp-relative relocation against dynamic
symbol _pam_token_returns
collect2: ld returned 1 exit status
make[2]: *** [pam_debug.so] Error 1
make[1]: *** [all] Error 1
make: *** [modules] Error 2

I've included the pertinent information supplied at
(http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html), the =
actual
error msg generated and system information. One other thing, I've tried
different versions of "Binutils" but the error persists. I've even tried
different versions of GCC but unfortunately GCC 2.96 was considered
'unacceptable' by the config script.  Thank you, Will L G

------=_NextPart_000_001F_01C3C426.FF0BF180
Content-Type: application/x-compressed;
	name="PAM-ERROR.log.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="PAM-ERROR.log.tgz"

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

------=_NextPart_000_001F_01C3C426.FF0BF180
Content-Type: application/x-compressed;
	name="systeminfo.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="systeminfo.tgz"

H4sICDje3z8AA3N5c3RlbWluZm8udGFyAO2WT2/bOBDFc40+xQC9xNjaoP5TAXpI3CINsAa8SA8B
ghxoinKEyqJCyUGdT78zlFSnDTZ1AxTbAnwHJf5x3uOQIp20u7ZTm7Iu9NEvE/MZS6LoiPX6/meY
pDiWpkmaxkkaI/f9FMuB/bqW9tq2nTAAR0br7qW6H43/oZLN9vj4+BTOquZOePgJNjpXFaHl/CxO
LHoQphRdqWvCqUVGPZTtQJglrcKiCurtZqUMUq+1Rwu6XaOo6sO5n0Qj3CeewtX1k4Fvcwf4LFru
ZKWgMOp+q2q5g5uPj7fI43AQeF25UeZ5hc+CaMaY14i1grZ8VHCz2nWqpTHuZ4HX3O3aGYg8N6pt
YVV2LY5EzNuILz2eQdsIqeANpQWpd67XenG5vDq26XE8S7j3WZlaVbCtRVWua5WDkJKGs4RnDE4a
+a4gSTr9schjX759EE9YEq1WoZx4W1z4s5Q+gJGDTbymEl2hDe5RZ8p6TV28L9dlh9tlX+lyDri7
V9e0N7D4+EivqoVcdUp2KrdNezTllDG/gFPIN4JAQCAk0JSSQEQgJmB3FklCJCHyWe1WWpgcYUqQ
M4Smkx7AQNJiIIwJ+rwakgMEkkA+zI3ALxD4RYqgzBXzWFDwKT6ooj8IJ2Lb6YnHwpWc4kNRljCN
Nh1Wh5QX2ryHtfgLQZFM6fE1L6S88Hkep23gzA7887delxLm2jQzuLxa+gFnuJyxhKa8r4SlPCIW
2SWGc72xJm3s6YZQZiw+x4PBzkWrPl3DzRyPrq7VLaU9cTJ2yrIZpXFidoOWRm/KVsEnJe9qXen1
7i1c1nIGAQuSwAbYYj7s1YA4oaJHoUXZPvL9vDfzSBKUBOe67sQ9LEppdH/jWuCBTLIQTt4EExvR
V399KRbxMQCRj4k51eTpYZ3vi23n+DvF5Qesm0eKvCo8bCIVUHGwn0hFBA5ok2X9H6gpy1J7OdGy
EJ3RX+DCiOaulO1Qv7g4w3eM9+wCbha4gyV+69yin4/+4lV+Mc4v8EIU/30wcTwYC8Oh8EdrE3il
B0s8WH7m9KItGf3J69aWjv704Jb5aOGD5cWjG07Ik42eLHxVm1k0+qOXX0EWj4XxAc1FfXPJ6EnY
T3+D/N//Ozg5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5/T76F0aNUCEAKAAA

------=_NextPart_000_001F_01C3C426.FF0BF180--

