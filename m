Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUKKAeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUKKAeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUKKAeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:34:36 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:16543 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262071AbUKKAeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:34:12 -0500
Message-ID: <4192B375.5000206@g-house.de>
Date: Thu, 11 Nov 2004 01:33:57 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de, piggin@cyberone.com.au
Subject: [PATCH] minor scheduler documentation fix
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050209020809060602080603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050209020809060602080603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

i'm using the CFQ scheduler for my desktop now. on the way to the right
docs i stumbled over these little things. please apply.

thanks,
Christian.

- --
BOFH excuse #187:

Reformatting Page. Wait...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkrN1+A7rjkF8z0wRAvWgAJ0fnhok+ITGaZCt7OqyaHnXXTzuzgCeIbt7
qjyQaOoOjkd2Q3ORVy5B7cs=
=LqX7
-----END PGP SIGNATURE-----

--------------050209020809060602080603
Content-Type: text/plain;
 name="sched-doc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sched-doc.diff"

LS0tIGxpbnV4LTIuNi1CSy9Eb2N1bWVudGF0aW9uL2Jsb2NrL2FzLWlvc2NoZWQudHh0CTIw
MDQtMTEtMTAgMjI6NTc6MzQuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYtQksvRG9j
dW1lbnRhdGlvbi9ibG9jay9hcy1pb3NjaGVkLnR4dC5lZGl0ZWQJMjAwNC0xMS0xMSAwMDo1
NToxMC4wMDAwMDAwMDAgKzAxMDAKQEAgLTEzMiw3ICsxMzIsNyBAQAogVHVuaW5nIHRoZSBh
bnRpY2lwYXRvcnkgSU8gc2NoZWR1bGVyCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KIFdoZW4gdXNpbmcgJ2FzJywgdGhlIGFudGljaXBhdG9yeSBJTyBzY2hlZHVs
ZXIgdGhlcmUgYXJlIDUgcGFyYW1ldGVycyB1bmRlcgotL3N5cy9ibG9jay8qL2lvc2NoZWQv
LiBBbGwgYXJlIHVuaXRzIG9mIG1pbGxpc2Vjb25kcy4KKy9zeXMvYmxvY2svKi9xdWV1ZS9p
b3NjaGVkLy4gQWxsIGFyZSB1bml0cyBvZiBtaWxsaXNlY29uZHMuCiAKIFRoZSBwYXJhbWV0
ZXJzIGFyZToKICogcmVhZF9leHBpcmUKLS0tIGxpbnV4LTIuNi1CSy9Eb2N1bWVudGF0aW9u
L2Jsb2NrL2RlYWRsaW5lLWlvc2NoZWQudHh0CTIwMDQtMTEtMTAgMjI6NTc6MzQuMDAwMDAw
MDAwICswMTAwCisrKyBsaW51eC0yLjYtQksvRG9jdW1lbnRhdGlvbi9ibG9jay9kZWFkbGlu
ZS1pb3NjaGVkLnR4dC5lZGl0ZWQJMjAwNC0xMS0xMSAwMDo1NjozOS4wMDAwMDAwMDAgKzAx
MDAKQEAgLTksNyArOSw3IEBACiB0dW5hYmxlcyBjb250cm9sIGhvdyB0aGUgaW8gc2NoZWR1
bGVyIHdvcmtzLiBZb3UgY2FuIGZpbmQgdGhlc2UgZW50cmllcwogaW46CiAKLS9zeXMvYmxv
Y2svPGRldmljZT4vaW9zY2hlZAorL3N5cy9ibG9jay88ZGV2aWNlPi9xdWV1ZS9pb3NjaGVk
CiAKIGFzc3VtaW5nIHRoYXQgeW91IGhhdmUgc3lzZnMgbW91bnRlZCBvbiAvc3lzLiBJZiB5
b3UgZG9uJ3QgaGF2ZSBzeXNmcyBtb3VudGVkLAogeW91IGNhbiBkbyBzbyBieSB0eXBpbmc6
Ci0tLSBsaW51eC0yLjYtQksvRG9jdW1lbnRhdGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQJ
MjAwNC0xMS0xMCAyMjo1NzozMy4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi1CSy9E
b2N1bWVudGF0aW9uL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dC5lZGl0ZWQJMjAwNC0xMS0xMSAw
MTowMzoyNS4wMDAwMDAwMDAgKzAxMDAKQEAgLTQwNCw3ICs0MDQsOCBAQAogCiAJZWxldmF0
b3I9CVtJT1NDSEVEXQogCQkJRm9ybWF0OiB7ImFzInwiY2ZxInwiZGVhZGxpbmUifCJub29w
In0KLQkJCVNlZSBEb2N1bWVudGF0aW9uL2FzLWlvc2NoZWQudHh0IGZvciBkZXRhaWxzCisJ
CQlTZWUgRG9jdW1lbnRhdGlvbi9ibG9jay9hcy1pb3NjaGVkLnR4dAorCQkJYW5kIERvY3Vt
ZW50YXRpb24vYmxvY2svZGVhZGxpbmUtaW9zY2hlZC50eHQgZm9yIGRldGFpbHMuCiAKIAll
czEzNzA9CQlbSFcsT1NTXQogCQkJRm9ybWF0OiA8bGluZW91dD5bLDxtaWNiaWFzPl0K
--------------050209020809060602080603--
