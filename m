Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261722AbSJJQwK>; Thu, 10 Oct 2002 12:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbSJJQwK>; Thu, 10 Oct 2002 12:52:10 -0400
Received: from email.gcom.com ([206.221.230.194]:37563 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S261716AbSJJQwI>;
	Thu, 10 Oct 2002 12:52:08 -0400
Message-Id: <5.1.0.14.2.20021010115616.04a0de70@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 11:57:46 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com, bidulock@openss7.org
In-Reply-To: <4386E3211F1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_1710900895==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_1710900895==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Attached is the "final" patch.  I eliminated the unregister function.  This 
is tested on stock 2.4.19 kernel.

Will someone see that it is added to the kernel source?

Thanks,
Dave
--=====================_1710900895==_
Content-Type: text/plain; name="stock-i386-2.4.19.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="stock-i386-2.4.19.txt"

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUy5vcmlnCTIwMDItMDgtMDIgMTk6Mzk6NDIuMDAw
MDAwMDAwIC0wNTAwCisrKyBhcmNoL2kzODYva2VybmVsL2VudHJ5LlMJMjAwMi0xMC0wOCAxNTo0
MzowOC4wMDAwMDAwMDAgLTA1MDAKQEAgLTU4NCw4ICs1ODQsOCBAQAogCS5sb25nIFNZTUJPTF9O
QU1FKHN5c19jYXBzZXQpICAgICAgICAgICAvKiAxODUgKi8KIAkubG9uZyBTWU1CT0xfTkFNRShz
eXNfc2lnYWx0c3RhY2spCiAJLmxvbmcgU1lNQk9MX05BTUUoc3lzX3NlbmRmaWxlKQotCS5sb25n
IFNZTUJPTF9OQU1FKHN5c19uaV9zeXNjYWxsKQkJLyogc3RyZWFtczEgKi8KLQkubG9uZyBTWU1C
T0xfTkFNRShzeXNfbmlfc3lzY2FsbCkJCS8qIHN0cmVhbXMyICovCisJLmxvbmcgU1lNQk9MX05B
TUUoc3lzX2dldHBtc2cpCQkvKiBzdHJlYW1zMSAqLworCS5sb25nIFNZTUJPTF9OQU1FKHN5c19w
dXRwbXNnKQkJLyogc3RyZWFtczIgKi8KIAkubG9uZyBTWU1CT0xfTkFNRShzeXNfdmZvcmspICAg
ICAgICAgICAgLyogMTkwICovCiAJLmxvbmcgU1lNQk9MX05BTUUoc3lzX2dldHJsaW1pdCkKIAku
bG9uZyBTWU1CT0xfTkFNRShzeXNfbW1hcDIpCi0tLSBrZXJuZWwva3N5bXMuYy5vcmlnCTIwMDIt
MDgtMDIgMTk6Mzk6NDYuMDAwMDAwMDAwIC0wNTAwCisrKyBrZXJuZWwva3N5bXMuYwkyMDAyLTEw
LTEwIDExOjQ2OjU0LjAwMDAwMDAwMCAtMDUwMApAQCAtNDk3LDYgKzQ5Nyw5IEBACiBFWFBPUlRf
U1lNQk9MKHNlcV9yZWxlYXNlKTsKIEVYUE9SVF9TWU1CT0woc2VxX3JlYWQpOwogRVhQT1JUX1NZ
TUJPTChzZXFfbHNlZWspOworZXh0ZXJuIGludCByZWdpc3Rlcl9zdHJlYW1zX2NhbGxzKGludCAo
KnB1dHBtc2cpIChpbnQsdm9pZCAqLHZvaWQgKixpbnQsaW50KSwKKwkJCQkgICBpbnQgKCpnZXRw
bXNnKSAoaW50LHZvaWQgKix2b2lkICosaW50LGludCkpOworRVhQT1JUX1NZTUJPTChyZWdpc3Rl
cl9zdHJlYW1zX2NhbGxzKTsKIAogLyogUHJvZ3JhbSBsb2FkZXIgaW50ZXJmYWNlcyAqLwogRVhQ
T1JUX1NZTUJPTChzZXR1cF9hcmdfcGFnZXMpOwotLS0ga2VybmVsL3N5cy5jLm9yaWcJMjAwMi0w
OC0wMiAxOTozOTo0Ni4wMDAwMDAwMDAgLTA1MDAKKysrIGtlcm5lbC9zeXMuYwkyMDAyLTEwLTEw
IDExOjQ2OjQ0LjAwMDAwMDAwMCAtMDUwMApAQCAtMTY3LDYgKzE2Nyw0OCBAQAogCXJldHVybiBu
b3RpZmllcl9jaGFpbl91bnJlZ2lzdGVyKCZyZWJvb3Rfbm90aWZpZXJfbGlzdCwgbmIpOwogfQog
CitzdGF0aWMgaW50ICgqZG9fcHV0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICosIGludCwgaW50
KSA9IE5VTEw7CitzdGF0aWMgaW50ICgqZG9fZ2V0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICos
IGludCwgaW50KSA9IE5VTEw7CisKK3N0YXRpYyBERUNMQVJFX1JXU0VNKHN0cmVhbXNfY2FsbF9z
ZW0pIDsKKworbG9uZyBhc21saW5rYWdlIHN5c19wdXRwbXNnKGludCBmZCwgdm9pZCAqY3RscHRy
LCB2b2lkICpkYXRwdHIsIGludCBiYW5kLCBpbnQgZmxhZ3MpCit7CisJaW50IHJldCA9IC1FTk9T
WVM7CisJZG93bl9yZWFkKCZzdHJlYW1zX2NhbGxfc2VtKSA7CS8qIHNob3VsZCByZXR1cm4gaW50
LCBidXQgZG9lc24ndCAqLworCWlmIChkb19wdXRwbXNnKQorCQlyZXQgPSAoKmRvX3B1dHBtc2cp
IChmZCwgY3RscHRyLCBkYXRwdHIsIGJhbmQsIGZsYWdzKTsKKwl1cF9yZWFkKCZzdHJlYW1zX2Nh
bGxfc2VtKTsKKwlyZXR1cm4gcmV0OworfQorCitsb25nIGFzbWxpbmthZ2Ugc3lzX2dldHBtc2co
aW50IGZkLCB2b2lkICpjdGxwdHIsIHZvaWQgKmRhdHB0ciwgaW50IGJhbmQsIGludCBmbGFncykK
K3sKKwlpbnQgcmV0ID0gLUVOT1NZUzsKKwlkb3duX3JlYWQoJnN0cmVhbXNfY2FsbF9zZW0pIDsJ
Lyogc2hvdWxkIHJldHVybiBpbnQsIGJ1dCBkb2Vzbid0ICovCisJaWYgKGRvX2dldHBtc2cpCisJ
CXJldCA9ICgqZG9fZ2V0cG1zZykgKGZkLCBjdGxwdHIsIGRhdHB0ciwgYmFuZCwgZmxhZ3MpOwor
CXVwX3JlYWQoJnN0cmVhbXNfY2FsbF9zZW0pOworCXJldHVybiByZXQ7Cit9CisKK2ludCByZWdp
c3Rlcl9zdHJlYW1zX2NhbGxzKGludCAoKnB1dHBtc2cpIChpbnQsIHZvaWQgKiwgdm9pZCAqLCBp
bnQsIGludCksCisJCQkgICAgaW50ICgqZ2V0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICosIGlu
dCwgaW50KSkKK3sKKwlpbnQgcmV0ID0gMDsKKwlkb3duX3dyaXRlKCZzdHJlYW1zX2NhbGxfc2Vt
KSA7CS8qIHNob3VsZCByZXR1cm4gaW50LCBidXQgZG9lc24ndCAqLworCWlmICggICAocHV0cG1z
ZyAhPSBOVUxMICYmIGRvX3B1dHBtc2cgIT0gTlVMTCkKKwkgICAgfHwgKGdldHBtc2cgIT0gTlVM
TCAmJiBkb19nZXRwbXNnICE9IE5VTEwpCisJICAgKQorCQlyZXQgPSAtRUJVU1k7CisJZWxzZSB7
CisJCWRvX3B1dHBtc2cgPSBwdXRwbXNnOworCQlkb19nZXRwbXNnID0gZ2V0cG1zZzsKKwl9CisJ
dXBfd3JpdGUoJnN0cmVhbXNfY2FsbF9zZW0pOworCXJldHVybiByZXQgOworfQorCiBhc21saW5r
YWdlIGxvbmcgc3lzX25pX3N5c2NhbGwodm9pZCkKIHsKIAlyZXR1cm4gLUVOT1NZUzsK
--=====================_1710900895==_--

