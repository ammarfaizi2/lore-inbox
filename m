Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUJKPhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUJKPhy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUJKPh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:37:29 -0400
Received: from main.uucpssh.org ([212.27.33.224]:29328 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S269129AbUJKPfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:35:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 [missing i2o patch in the main patch]
References: <20041011032502.299dc88d.akpm@osdl.org>
From: syrius.ml@no-log.org
Message-ID: <87y8idnvmm.87wtxxnvmm@87vfdhnvmm.message.id>
Date: Mon, 11 Oct 2004 17:33:07 +0200
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 11 Oct 2004 03:25:02 -0700")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrew Morton <akpm@osdl.org> writes:


> i2o-new-functions-to-convert-messages-to-a-virtual-address.patch
>   i2o: new functions to convert messages to a virtual address

looking at
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/i2o-new-functions-to-convert-messages-to-a-virtual-address.patch,
it seems the include/linux/i2o.h patch is missing:

tell me if I'm wrong, but i think this patch is missing:


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment;
  filename=i2o-new-functions-to-convert-messages-to-a-virtual-address.patch4
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGluY2x1ZGUvbGludXgvaTJvLmh+aTJvLW5ldy1mdW5jdGlvbnMtdG8tY29udmVy
dC1tZXNzYWdlcy10by1hLXZpcnR1YWwtYWRkcmVzcyBpbmNsdWRlL2xpbnV4L2kyby5oCi0tLSAy
NS9pbmNsdWRlL2xpbnV4L2kyby5ofmkyby1uZXctZnVuY3Rpb25zLXRvLWNvbnZlcnQtbWVzc2Fn
ZXMtdG8tYS12aXJ0dWFsLWFkZHJlc3MJRnJpIE9jdCAgOCAxNDozMjozNiAyMDA0CisrKyAyNS1h
a3BtL2luY2x1ZGUvbGludXgvaTJvLmgJRnJpIE9jdCAgOCAxNDozMjozNiAyMDA0CkBAIC00Nyw3
ICs0Nyw3IEBAIHN0cnVjdCBpMm9fbWVzc2FnZSB7CiAJCQl1MzIgZnVuY3Rpb246ODsKIAkJCXUz
MiBpY250eHQ7CS8qIGluaXRpYXRvciBjb250ZXh0ICovCiAJCQl1MzIgdGNudHh0OwkvKiB0cmFu
c2FjdGlvbiBjb250ZXh0ICovCi0JCX0gczsKKwkJfSBfX2F0dHJpYnV0ZSgocGFja2VkKSkgczsK
IAkJdTMyIGhlYWRbNF07CiAJfSB1OwogCS8qIExpc3QgZm9sbG93cyAqLwpAQCAtMjUyLDYgKzI1
MiwxMSBAQCBleHRlcm4gaW50IGkyb19tc2dfcG9zdF93YWl0X21lbShzdHJ1Y3QgCiBleHRlcm4g
dm9pZCBpMm9fbXNnX25vcChzdHJ1Y3QgaTJvX2NvbnRyb2xsZXIgKiwgdTMyKTsKIHN0YXRpYyBp
bmxpbmUgdm9pZCBpMm9fZmx1c2hfcmVwbHkoc3RydWN0IGkyb19jb250cm9sbGVyICosIHUzMik7
CiAKK3N0YXRpYyBpbmxpbmUgc3RydWN0IGkyb19tZXNzYWdlICppMm9fbXNnX2luX3RvX3ZpcnQo
c3RydWN0IGkyb19jb250cm9sbGVyICosCisJCQkJCQkgICAgIHUzMik7CitzdGF0aWMgaW5saW5l
IHN0cnVjdCBpMm9fbWVzc2FnZSAqaTJvX21zZ19vdXRfdG9fdmlydChzdHJ1Y3QgaTJvX2NvbnRy
b2xsZXIKKwkJCQkJCSAgICAgICosIHUzMik7CisKIC8qIERNQSBoYW5kbGluZyBmdW5jdGlvbnMg
Ki8KIHN0YXRpYyBpbmxpbmUgaW50IGkyb19kbWFfYWxsb2Moc3RydWN0IGRldmljZSAqLCBzdHJ1
Y3QgaTJvX2RtYSAqLCBzaXplX3QsCiAJCQkJdW5zaWduZWQgaW50KTsKQEAgLTUwMiw2ICs1MDcs
NDUgQEAgc3RhdGljIGlubGluZSB2b2lkIGkyb19mbHVzaF9yZXBseShzdHJ1YwogfTsKIAogLyoq
CisgKglpMm9fb3V0X3RvX3ZpcnQgLSBUdXJuIGFuIEkyTyBtZXNzYWdlIHRvIGEgdmlydHVhbCBh
ZGRyZXNzCisgKglAYzogY29udHJvbGxlcgorICoJQG06IG1lc3NhZ2UgZW5naW5lIHZhbHVlCisg
KgorICoJVHVybiBhIHJlY2VpdmUgbWVzc2FnZSBmcm9tIGFuIEkyTyBjb250cm9sbGVyIGJ1cyBh
ZGRyZXNzIGludG8KKyAqCWEgTGludXggdmlydHVhbCBhZGRyZXNzLiBUaGUgc2hhcmVkIHBhZ2Ug
ZnJhbWUgaXMgYSBsaW5lYXIgYmxvY2sKKyAqCXNvIHdlIHNpbXBseSBoYXZlIHRvIHNoaWZ0IHRo
ZSBvZmZzZXQuIFRoaXMgZnVuY3Rpb24gZG9lcyBub3QKKyAqCXdvcmsgZm9yIHNlbmRlciBzaWRl
IG1lc3NhZ2VzIGFzIHRoZXkgYXJlIGlvcmVtYXAgb2JqZWN0cworICoJcHJvdmlkZWQgYnkgdGhl
IEkyTyBjb250cm9sbGVyLgorICovCitzdGF0aWMgaW5saW5lIHN0cnVjdCBpMm9fbWVzc2FnZSAq
aTJvX21zZ19vdXRfdG9fdmlydChzdHJ1Y3QgaTJvX2NvbnRyb2xsZXIgKmMsCisJCQkJCQkgICAg
ICB1MzIgbSkKK3sKKwlpZiAodW5saWtlbHkKKwkgICAgKG0gPCBjLT5vdXRfcXVldWUucGh5cwor
CSAgICAgfHwgbSA+PSBjLT5vdXRfcXVldWUucGh5cyArIGMtPm91dF9xdWV1ZS5sZW4pKQorCQlC
VUcoKTsKKworCXJldHVybiBjLT5vdXRfcXVldWUudmlydCArIChtIC0gYy0+b3V0X3F1ZXVlLnBo
eXMpOworfTsKKworLyoqCisgKglpMm9fbXNnX2luX3RvX3ZpcnQgLSBUdXJuIGFuIEkyTyBtZXNz
YWdlIHRvIGEgdmlydHVhbCBhZGRyZXNzCisgKglAYzogY29udHJvbGxlcgorICoJQG06IG1lc3Nh
Z2UgZW5naW5lIHZhbHVlCisgKgorICoJVHVybiBhIHNlbmQgbWVzc2FnZSBmcm9tIGFuIEkyTyBj
b250cm9sbGVyIGJ1cyBhZGRyZXNzIGludG8KKyAqCWEgTGludXggdmlydHVhbCBhZGRyZXNzLiBU
aGUgc2hhcmVkIHBhZ2UgZnJhbWUgaXMgYSBsaW5lYXIgYmxvY2sKKyAqCXNvIHdlIHNpbXBseSBo
YXZlIHRvIHNoaWZ0IHRoZSBvZmZzZXQuIFRoaXMgZnVuY3Rpb24gZG9lcyBub3QKKyAqCXdvcmsg
Zm9yIHJlY2VpdmUgc2lkZSBtZXNzYWdlcyBhcyB0aGV5IGFyZSBrbWFsbG9jIG9iamVjdHMKKyAq
CWluIGEgZGlmZmVyZW50IHBvb2wuCisgKi8KK3N0YXRpYyBpbmxpbmUgc3RydWN0IGkyb19tZXNz
YWdlICppMm9fbXNnX2luX3RvX3ZpcnQoc3RydWN0IGkyb19jb250cm9sbGVyICpjLAorCQkJCQkJ
ICAgICB1MzIgbSkKK3sKKwlyZXR1cm4gYy0+aW5fcXVldWUudmlydCArIG07Cit9OworCisvKioK
ICAqCWkyb19kbWFfYWxsb2MgLSBBbGxvY2F0ZSBETUEgbWVtb3J5CiAgKglAZGV2OiBzdHJ1Y3Qg
ZGV2aWNlIHBvaW50ZXIgdG8gdGhlIFBDSSBkZXZpY2Ugb2YgdGhlIEkyTyBjb250cm9sbGVyCiAg
KglAYWRkcjogaTJvX2RtYSBzdHJ1Y3Qgd2hpY2ggc2hvdWxkIGdldCB0aGUgRE1BIGJ1ZmZlcgpf
Cg==
--=-=-=


at least it resolves the unknown symbol i2o_msg_in_to_virt issues for
me ;-)


-- 

--=-=-=--
