Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVBDRYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVBDRYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbVBDRWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:22:48 -0500
Received: from web88208.mail.re2.yahoo.com ([206.190.37.223]:22926 "HELO
	web88208.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S265866AbVBDRU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:20:26 -0500
Message-ID: <20050204172023.76200.qmail@web88208.mail.re2.yahoo.com>
Date: Fri, 4 Feb 2005 12:20:23 -0500 (EST)
From: LAWRENCE WILLIAMS <lawrencewilliams@nl.rogers.com>
Subject: Bug in ns558 affecting gameports
To: linux-kernel@vger.kernel.org, perex@suse.cz
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-271497898-1107537623=:76052"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-271497898-1107537623=:76052
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello,

I am sending this report because this has been an
off-again, on-again problem in the 2.6 kernel series.
Everything was fine when the snd-intel8x0 had built-in
gameport support from 2.6.5(??) to 2.6.9. I just
simply had to add a file to /etc/modprobe.d containing
the following line

options snd-intel8x0 joystick=1

And everything worked fine. Now I recently installed
2.6.10 in Debian and kept getting the same error as
has been reported by others ( see ). The patch
attached to that bug report works against 2.6.10 and
fixes the problem ( at least it did for me ).

I would like to see this problem fixed and I'm willing
to help in any way I can. Attached to this message is
the patch I mentioned above.

Thanks!

Lawrence Williams
--0-271497898-1107537623=:76052
Content-Type: application/octet-stream; name="ns558.patch"
Content-Transfer-Encoding: base64
Content-Description: ns558.patch
Content-Disposition: attachment; filename="ns558.patch"

LS0tIGEvZHJpdmVycy9pbnB1dC9nYW1lcG9ydC9uczU1OC5jCTIwMDQtMDUt
MTAgMDI6MzM6MTMuMDAwMDAwMDAwICswMDAwCisrKyBiL2RyaXZlcnMvaW5w
dXQvZ2FtZXBvcnQvbnM1NTguYwkyMDA0LTA2LTI4IDEwOjQzOjI4LjAwMDAw
MDAwMCArMDAwMApAQCAtMjYwLDE5ICsyNjAsMTkgQEAKIAogI2VuZGlmCiAK
K3N0YXRpYyBpbnQgcmVnaXN0ZXJlZCA9IDA7CisKIGludCBfX2luaXQgbnM1
NThfaW5pdCh2b2lkKQogewogCWludCBpID0gMDsKIAotLyoKLSAqIFByb2Jl
IGZvciBJU0EgcG9ydHMuCi0gKi8KKwlpZiAocG5wX3JlZ2lzdGVyX2RyaXZl
cigmbnM1NThfcG5wX2RyaXZlcik+PTApCisJCXJlZ2lzdGVyZWQgPSAxOwog
CiAJd2hpbGUgKG5zNTU4X2lzYV9wb3J0bGlzdFtpXSkKIAkJbnM1NThfaXNh
X3Byb2JlKG5zNTU4X2lzYV9wb3J0bGlzdFtpKytdKTsKIAotCXBucF9yZWdp
c3Rlcl9kcml2ZXIoJm5zNTU4X3BucF9kcml2ZXIpOwotCXJldHVybiBsaXN0
X2VtcHR5KCZuczU1OF9saXN0KSA/IC1FTk9ERVYgOiAwOworCXJldHVybiAw
OwogfQogCiB2b2lkIF9fZXhpdCBuczU1OF9leGl0KHZvaWQpCkBAIC0yOTYs
NiArMjk2LDcgQEAKIAkJCQlicmVhazsKIAkJfQogCX0KKwlpZiAocmVnaXN0
ZXJlZCkKIAlwbnBfdW5yZWdpc3Rlcl9kcml2ZXIoJm5zNTU4X3BucF9kcml2
ZXIpOwogfQogCg==

--0-271497898-1107537623=:76052--
