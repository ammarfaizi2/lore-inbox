Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUF0FsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUF0FsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 01:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUF0FsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 01:48:14 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:50084 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S266262AbUF0FsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 01:48:10 -0400
Message-ID: <40DE5F92.8000703@ThinRope.net>
Date: Sun, 27 Jun 2004 14:48:02 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: David Eger <eger@havoc.gtf.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Translate Japanese comments in arch/v850  ( was: Alphabet
 of kernel source)
References: <20040623140628.3f1abfe9@lembas.zaitcev.lan> <20040623214653.GA29728@havoc.gtf.org> <40DA01C1.2030102@ThinRope.net> <20040624061642.GA8506@havoc.gtf.org>
In-Reply-To: <20040624061642.GA8506@havoc.gtf.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010205080908090102050306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205080908090102050306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Eger wrote:
>>>http://www.yak.net/random/linux-2.6.4-utf8-cleanup-jp.diff
>>
>>Ok, this Japanese is only in the comments.
>>I can translate that in no time and fix this diff.
> 
> actually, I'm pretty sure the diff is correct against 2.6.4 - the bytes
> should all be correct, as I checked it with someone who works with
> said files...

OK, I had a few idle minutes, so I did patch the Japanese comments in arch/v850.

I am not exactly 100% sure I translated it correctly since I have no idea what exactly was that NEC v850 evaluation board, but should be OK (say 95% sure).

Patches just the comments, so code is untouched.

The other thing is that one of the files was encoded (i.e. readable) in iso-2022-jp, the other in euc-jp...
No idea how patch will handle this, I hope it doesn't bother with locale settings, etc.

Attaching as application/octet-stream in a hope for better handling of i18n issues, sorry for the inconvenience.

Here goes the patch:

Signed-off-by: Kalin KOZHUHAROV <kalin@thinrope.net>


--------------010205080908090102050306
Content-Type: application/octet-stream;
 name="v850-jp2en.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="v850-jp2en.diff"

ZGlmZiAtcnUgL3Vzci9zcmMvbGludXgvYXJjaC92ODUwL2tlcm5lbC9hczg1ZXAxLmMgLi9h
czg1ZXAxLmMKLS0tIEEvYXJjaC92ODUwL2tlcm5lbC9hczg1ZXAxLmMJMjAwNC0wNi0xNiAx
NDoyMDowNC4wMDAwMDAwMDAgKzA5MDAKKysrIEIvYXJjaC92ODUwL2tlcm5lbC9hczg1ZXAx
LmMJMjAwNC0wNi0yNyAxNDozMTowMS4zOTk3OTM0MzkgKzA5MDAKQEAgLTU3LDEwICs1Nywx
MCBAQAogCUFTODVFUDFfQVNDICAgID0gMDsKIAlBUzg1RVAxX0xCUyAgICA9IDB4MDBBOTsK
IAotCUFTODVFUDFfUE9SVF9QTUMoNikgID0gMHhGRjsgLyogQTIwLTI1LCBBMCxBMSAbJEJN
LTh6GyhCICovCi0JQVM4NUVQMV9QT1JUX1BNQyg3KSAgPSAweDBFOyAvKiBDUzEsMiwzICAg
ICAgIBskQk0tOHobKEIgKi8KLQlBUzg1RVAxX1BPUlRfUE1DKDkpICA9IDB4RkY7IC8qIEQx
Ni0yMyAgICAgICAgGyRCTS04ehsoQiAqLwotCUFTODVFUDFfUE9SVF9QTUMoMTApID0gMHhG
RjsgLyogRDI0LTMxICAgICAgICAbJEJNLTh6GyhCICovCisJQVM4NUVQMV9QT1JUX1BNQyg2
KSAgPSAweEZGOyAvKiB2YWxpZCBBMCxBMSxBMjAtQTI1ICovCisJQVM4NUVQMV9QT1JUX1BN
Qyg3KSAgPSAweDBFOyAvKiB2YWxpZCBDUzEtQ1MzICAgICAgICovCisJQVM4NUVQMV9QT1JU
X1BNQyg5KSAgPSAweEZGOyAvKiB2YWxpZCBEMTYtRDIzICAgICAgICovCisJQVM4NUVQMV9Q
T1JUX1BNQygxMCkgPSAweEZGOyAvKiB2YWxpZCBEMjQtRDMxICAgICAgICovCiAKIAlBUzg1
RVAxX1JGUygxKSA9IDB4ODAwYzsKIAlBUzg1RVAxX1JGUygzKSA9IDB4ODAwYzsKQEAgLTc2
LDcgKzc2LDcgQEAKIAkgICB3cml0ZSB0byBhZGRyZXNzIChOIC0gMHgxMCkuICBXZSBhdm9p
ZCB0aGlzIChlZmZlY3RpdmVseSkgYnkKIAkgICB3cml0aW5nIGluIDE2LWJ5dGUgY2h1bmtz
IGJhY2t3YXJkcyBmcm9tIHRoZSBlbmQuICAqLwogCi0JQVM4NUVQMV9JUkFNTSA9IDB4MzsJ
LyogGyRCRmJCIkw/TmEbKEJSQU0bJEIkTyFWGyhCd3JpdGUtbW9kZRskQiFXJEskSiRqJF4k
ORsoQiAqLworCUFTODVFUDFfSVJBTU0gPSAweDM7CS8qICJ3cml0ZS1tb2RlIiBmb3IgdGhl
IGludGVybmFsIGluc3RydWN0aW9uIG1lbW9yeSAqLwogCiAJc3JjID0gKHUzMiAqKSgoKHUz
MikmX2ludHZfY29weV9zcmNfZW5kIC0gMSkgJiB+MHhGKTsKIAlkc3QgPSAodTMyICopJl9p
bnR2X2NvcHlfZHN0X3N0YXJ0CkBAIC04OCw3ICs4OCw3IEBACiAJCXNyYyAtPSA0OwogCX0g
d2hpbGUgKHNyYyA+ICh1MzIgKikmX2ludHZfY29weV9zcmNfc3RhcnQpOwogCi0JQVM4NUVQ
MV9JUkFNTSA9IDB4MDsJLyogGyRCRmJCIkw/TmEbKEJSQU0bJEIkTyFWGyhCcmVhZC1tb2Rl
GyRCIVckSyRKJGokXiQ5GyhCICovCisJQVM4NUVQMV9JUkFNTSA9IDB4MDsJLyogInJlYWQt
bW9kZSIgZm9yIHRoZSBpbnRlcm5hbCBpbnN0cnVjdGlvbiBtZW1vcnkgKi8KICNlbmRpZiAv
KiAhQ09ORklHX1JPTV9LRVJORUwgKi8KIAogCXY4NTBlX2ludGNfZGlzYWJsZV9pcnFzICgp
OwpkaWZmIC1ydSAvdXNyL3NyYy9saW51eC9hcmNoL3Y4NTAva2VybmVsL2FzODVlcDEubGQg
Li9hczg1ZXAxLmxkCi0tLSBBL2FyY2gvdjg1MC9rZXJuZWwvYXM4NWVwMS5sZAkyMDA0LTA2
LTE2IDE0OjE5OjQzLjAwMDAwMDAwMCArMDkwMAorKysgQi9hcmNoL3Y4NTAva2VybmVsL2Fz
ODVlcDEubGQJMjAwNC0wNi0yNyAxNDoyODo0My43NTYzNzUwMjQgKzA5MDAKQEAgLTIsNyAr
Miw3IEBACiAgICAoQ09ORklHX1Y4NTBFX0FTODVFUDEpLiAgKi8KIAogTUVNT1JZIHsKLQkv
KiAxTUIgb2YgaW50ZXJuYWwgbWVtb3J5ICjG4sKizL/O4VJBTSkuICAqLworCS8qIDFNQiBv
ZiBpbnRlcm5hbCBpbnN0cnVjdGlvbiBtZW1vcnkuICovCiAJaU1FTTAgOiBPUklHSU4gPSAw
LAkgICAgIExFTkdUSCA9IDB4MDAxMDAwMDAKIAogCS8qIDFNQiBvZiBzdGF0aWMgUkFNLiAg
Ki8K
--------------010205080908090102050306--
