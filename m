Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbTAUTrB>; Tue, 21 Jan 2003 14:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbTAUTrB>; Tue, 21 Jan 2003 14:47:01 -0500
Received: from mx7.mail.ru ([194.67.57.17]:40973 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S267197AbTAUTq7>;
	Tue, 21 Jan 2003 14:46:59 -0500
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATH] 2.4: fix media type detection in ide-scsi
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [62.118.135.41]
Date: Tue, 21 Jan 2003 22:56:03 +0300
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: multipart/mixed;
	boundary="----x2GTOgG4-rd7SVn41doLgqhlN:1043178963"
Message-Id: <E18b4V9-0002zF-00@f2.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------x2GTOgG4-rd7SVn41doLgqhlN:1043178963
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit

We are looking for IDE media types not for SCSI media.

BTW what is the purpose of loop over media types in idescsi_attach? The patch fixes media types there as well, but it does not appear to do anything useful.

regards

-andrey

------x2GTOgG4-rd7SVn41doLgqhlN:1043178963
Content-Type: application/octet-stream; name="2.4.21-0.pre3.1mdk.ide-scsi_media_types.patch"
Content-Disposition: attachment; filename="2.4.21-0.pre3.1mdk.ide-scsi_media_types.patch"
Content-Transfer-Encoding: base64

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNC4yMS0wLnByZTMuMW1kay9kcml2ZXJzL3Njc2kvaWRlLXNj
c2kuYwkyMDAzLTAxLTE2IDE5OjE3OjUzLjAwMDAwMDAwMCArMDMwMAorKysgbGludXgtMi40LjIx
LTAucHJlMy4xbWRrL2RyaXZlcnMvc2NzaS9pZGUtc2NzaS5jCTIwMDMtMDEtMjEgMjI6NDE6NDAu
MDAwMDAwMDAwICswMzAwCkBAIC03MzMsMTQgKzczMywxMiBAQAogaW50IGlkZXNjc2lfYXR0YWNo
IChpZGVfZHJpdmVfdCAqZHJpdmUpCiB7CiAJaWRlc2NzaV9zY3NpX3QgKnNjc2k7Ci0JdTggbWVk
aWFbXSA9IHsJVFlQRV9ESVNLLAkJLyogMHgwMCAqLwotCQkJVFlQRV9UQVBFLAkJLyogMHgwMSAq
LwotCQkJVFlQRV9QUklOVEVSLAkJLyogMHgwMiAqLwotCQkJVFlQRV9QUk9DRVNTT1IsCQkvKiAw
eDAzICovCi0JCQlUWVBFX1dPUk0sCQkvKiAweDA0ICovCi0JCQlUWVBFX1JPTSwJCS8qIDB4MDUg
Ki8KLQkJCVRZUEVfU0NBTk5FUiwJCS8qIDB4MDYgKi8KLQkJCVRZUEVfTU9ELAkJLyogMHgwNyAq
LworCXU4IG1lZGlhW10gPSB7CS8qIGlkZV9kaXNrLCB3ZSBkbyBub3Qgc3VwcG9ydCBJREUgZGlz
a3MgZm9yIG5vdyAqLworCQkJaWRlX29wdGljYWwsCisJCQlpZGVfY2Ryb20sCisJCQlpZGVfdGFw
ZSwKKwkJCWlkZV9mbG9wcHksCisJCQkvKiBpZGVfc2NzaSAtIHNob3VsZCB3ZSBzY2FuIGZvciBp
dCBhcyB3ZWxsPyAqLwogCQkJMjU1fTsKIAlpbnQgaSA9IDAsIHJldCA9IDAsIGlkID0gMDsKIC8v
CWludCBpZCA9IDIgKiBIV0lGKGRyaXZlKS0+aW5kZXggKyBkcml2ZS0+c2VsZWN0LmIudW5pdDsK
QEAgLTgwNSwxNCArODAzLDEyIEBACiAjaWZkZWYgQ0xBU1NJQ19CVUlMVElOU19NRVRIT0QKIAlp
ZGVfZHJpdmVfdCAqZHJpdmU7CiAJaWRlc2NzaV9zY3NpX3QgKnNjc2k7Ci0JdTggbWVkaWFbXSA9
IHsgIFRZUEVfRElTSywJCS8qIDB4MDAgKi8KLQkJCVRZUEVfVEFQRSwJCS8qIDB4MDEgKi8KLQkJ
CVRZUEVfUFJJTlRFUiwJCS8qIDB4MDIgKi8KLQkJCVRZUEVfUFJPQ0VTU09SLAkJLyogMHgwMyAq
LwotCQkJVFlQRV9XT1JNLAkJLyogMHgwNCAqLwotCQkJVFlQRV9ST00sCQkvKiAweDA1ICovCi0J
CQlUWVBFX1NDQU5ORVIsCQkvKiAweDA2ICovCi0JCQlUWVBFX01PRCwJCS8qIDB4MDcgKi8KKwl1
OCBtZWRpYVtdID0gewkvKiBpZGVfZGlzaywgd2UgZG8gbm90IHN1cHBvcnQgSURFIGRpc2tzIGZv
ciBub3cgKi8KKwkJCWlkZV9vcHRpY2FsLAorCQkJaWRlX2Nkcm9tLAorCQkJaWRlX3RhcGUsCisJ
CQlpZGVfZmxvcHB5LAorCQkJLyogaWRlX3Njc2kgLSBzaG91bGQgd2Ugc2NhbiBmb3IgaXQgYXMg
d2VsbD8gKi8KIAkJCTI1NX07CiAKIAlpbnQgaSwgZmFpbGVkLCBpZDsKQEAgLTExMzMsNyArMTEy
OSwxMyBAQAogc3RhdGljIHZvaWQgX19leGl0IGV4aXRfaWRlc2NzaV9tb2R1bGUodm9pZCkKIHsK
IAlpZGVfZHJpdmVfdCAqZHJpdmU7Ci0JdTggbWVkaWFbXSA9IHtUWVBFX0RJU0ssIFRZUEVfVEFQ
RSwgVFlQRV9QUk9DRVNTT1IsIFRZUEVfV09STSwgVFlQRV9ST00sIFRZUEVfU0NBTk5FUiwgVFlQ
RV9NT0QsIDI1NX07CisJdTggbWVkaWFbXSA9IHsJLyogaWRlX2Rpc2ssIHdlIGRvIG5vdCBzdXBw
b3J0IElERSBkaXNrcyBmb3Igbm93ICovCisJCQlpZGVfb3B0aWNhbCwKKwkJCWlkZV9jZHJvbSwK
KwkJCWlkZV90YXBlLAorCQkJaWRlX2Zsb3BweSwKKwkJCS8qIGlkZV9zY3NpIC0gc2hvdWxkIHdl
IHNjYW4gZm9yIGl0IGFzIHdlbGw/ICovCisJCQkyNTV9OwogCWludCBpLCBmYWlsZWQ7CiAKIAlz
Y3NpX3VucmVnaXN0ZXJfbW9kdWxlKE1PRFVMRV9TQ1NJX0hBLCAmaWRlc2NzaV90ZW1wbGF0ZSk7
Cg==

------x2GTOgG4-rd7SVn41doLgqhlN:1043178963--

