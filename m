Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTE2W7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTE2W7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:59:08 -0400
Received: from [62.39.112.246] ([62.39.112.246]:38368 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S263150AbTE2W7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:59:05 -0400
Date: Fri, 30 May 2003 01:12:11 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.21-rc5-ac2 doesn't build with gcc 3.3
Message-ID: <Pine.LNX.4.53.0305300104500.31258@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658437744-1736231177-1054249931=:31258"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658437744-1736231177-1054249931=:31258
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
Some 2.4.21-rc5-ac2 modules (actually 2.4.21-rc5-ac2 applied to 2.4.21-rc6 
w/ the conflicts resolved, but that shouldn't make a difference) don't 
compile with gcc 3.3.

Fix attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658437744-1736231177-1054249931=:31258
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.21-rc6-ac-gcc33.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305300112110.31258@dot.kde.org>
Content-Description: Fix build w/ gcc 3.3
Content-Disposition: attachment; filename="linux-2.4.21-rc6-ac-gcc33.patch"

LS0tIGxpbnV4LTIuNC4yMC9kcml2ZXJzL25ldC93YW4vc2JuaS5jLmJlcm8J
MjAwMy0wNS0zMCAwMDoyMDozNS4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51
eC0yLjQuMjAvZHJpdmVycy9uZXQvd2FuL3NibmkuYwkyMDAzLTA1LTMwIDAw
OjUwOjI4LjAwMDAwMDAwMCArMDIwMA0KQEAgLTE2MjEsNyArMTYyMSw3IEBA
DQogCSIyOlxuIg0KIAkJOg0KIAkJOiAiYSIgKF9jcmMpLCAiZyIgKHApLCAi
ZyIgKGxlbikNCi0JCTogImF4IiwgImJ4IiwgImN4IiwgImR4IiwgInNpIiwg
ImRpIg0KKwkJOiAiYngiLCAiY3giLCAiZHgiLCAic2kiLCAiZGkiDQogCSk7
DQogDQogCXJldHVybiAgX2NyYzsNCi0tLSBsaW51eC0yLjQuMjAvZHJpdmVy
cy9pMmMvaTJjLWFsaTE1MzUuYy5iZXJvCTIwMDMtMDUtMzAgMDA6MTM6NDIu
MDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi40LjIwL2RyaXZlcnMvaTJj
L2kyYy1hbGkxNTM1LmMJMjAwMy0wNS0zMCAwMDo1NToyOS4wMDAwMDAwMDAg
KzAyMDANCkBAIC02NzMsOCArNjczLDggQEANCiAjaWZkZWYgTU9EVUxFDQog
DQogTU9EVUxFX0FVVEhPUg0KLSAgICAoIkZyb2RvIExvb2lqYWFyZCA8ZnJv
ZG9sQGRkcy5ubD4sIFBoaWxpcCBFZGVsYnJvY2sgPHBoaWxAbmV0cm9lZGdl
LmNvbT4sDQotICAgICAgTWFyayBELiBTdHVkZWJha2VyIDxtZHN4eXoxMjNA
eWFob28uY29tPiBhbmQgRGFuIEVhdG9uIDxkYW4uZWF0b25Acm9ja2V0bG9n
aXguY29tPiIpOw0KKyAgICAoIkZyb2RvIExvb2lqYWFyZCA8ZnJvZG9sQGRk
cy5ubD4sIFBoaWxpcCBFZGVsYnJvY2sgPHBoaWxAbmV0cm9lZGdlLmNvbT4s
ICINCisgICAgICJNYXJrIEQuIFN0dWRlYmFrZXIgPG1kc3h5ejEyM0B5YWhv
by5jb20+IGFuZCBEYW4gRWF0b24gPGRhbi5lYXRvbkByb2NrZXRsb2dpeC5j
b20+Iik7DQogTU9EVUxFX0RFU0NSSVBUSU9OKCJBTEkxNTM1IFNNQnVzIGRy
aXZlciIpOw0KIA0KIGludCBpbml0X21vZHVsZSh2b2lkKQ0KLS0tIGxpbnV4
LTIuNC4yMC9kcml2ZXJzL3NlbnNvcnMvbG04Ny5jLmJlcm8JMjAwMy0wNS0z
MCAwMDo1MzozNS4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjQuMjAv
ZHJpdmVycy9zZW5zb3JzL2xtODcuYwkyMDAzLTA1LTMwIDAwOjU1OjM3LjAw
MDAwMDAwMCArMDIwMA0KQEAgLTEwNjEsMTAgKzEwNjEsMTAgQEANCiAjZW5k
aWYNCiANCiBNT0RVTEVfQVVUSE9SDQotICAgICgiRnJvZG8gTG9vaWphYXJk
IDxmcm9kb2xAZGRzLm5sPiwNCi0gICAgICBQaGlsaXAgRWRlbGJyb2NrIDxw
aGlsQG5ldHJvZWRnZS5jb20+LCANCi0gICAgICBNYXJrIFN0dWRlYmFrZXIg
PG1kc3h5ejEyM0B5YWhvby5jb20+LA0KLSAgICAgIGFuZCBTdGVwaGVuIFJv
dXNzZXQgPHN0ZXBoZW4ucm91c3NldEByb2NrZXRsb2dpeC5jb20+Iik7DQor
ICAgICgiRnJvZG8gTG9vaWphYXJkIDxmcm9kb2xAZGRzLm5sPiwgIg0KKyAg
ICAgIlBoaWxpcCBFZGVsYnJvY2sgPHBoaWxAbmV0cm9lZGdlLmNvbT4sICIN
CisgICAgICJNYXJrIFN0dWRlYmFrZXIgPG1kc3h5ejEyM0B5YWhvby5jb20+
LCAiDQorICAgICAiYW5kIFN0ZXBoZW4gUm91c3NldCA8c3RlcGhlbi5yb3Vz
c2V0QHJvY2tldGxvZ2l4LmNvbT4iKTsNCiANCiBNT0RVTEVfREVTQ1JJUFRJ
T04oIkxNODcgZHJpdmVyIik7DQogDQo=

--658437744-1736231177-1054249931=:31258--
