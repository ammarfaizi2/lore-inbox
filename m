Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291720AbSBTKdf>; Wed, 20 Feb 2002 05:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291732AbSBTKd0>; Wed, 20 Feb 2002 05:33:26 -0500
Received: from [203.94.130.164] ([203.94.130.164]:11012 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S291720AbSBTKdL>;
	Wed, 20 Feb 2002 05:33:11 -0500
Date: Wed, 20 Feb 2002 22:00:37 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 scsi changes : qlogicfas.c fixed
Message-ID: <Pine.LNX.4.44.0202202155190.2600-200000@bad-sports.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1590404226-2114864498-1014202837=:2600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1590404226-2114864498-1014202837=:2600
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hey,

Once again, thanks to people messing with the scsi layer, I'm forced to 
attempt to fix this driver, which it seems I'm the only one using :)

Like last time, I cannot confirm that this _works_ as my card is dodgy, 
but I can confirm that it compiles, and performs exactly as is did before 
the changes.

The changes seems simple enough.

thanks,

	/ Brett

--1590404226-2114864498-1014202837=:2600
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bp-qlogicscsifix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0202202200370.2600@bad-sports.com>
Content-Description: 
Content-Disposition: attachment; filename="bp-qlogicscsifix.patch"

LS0tIGRyaXZlcnMvc2NzaS9xbG9naWNmYXMuYy5iYWsJV2VkIEZlYiAyMCAy
MToyMzoxMSAyMDAyDQorKysgZHJpdmVycy9zY3NpL3Fsb2dpY2Zhcy5jCVdl
ZCBGZWIgMjAgMjE6MTg6MzcgMjAwMg0KQEAgLTM0NCw2ICszNDQsNyBAQA0K
IHVuc2lnbmVkIGludAlyZXFsZW47IAkJLyogdG90YWwgbGVuZ3RoIG9mIHRy
YW5zZmVyICovDQogc3RydWN0IHNjYXR0ZXJsaXN0CSpzZ2xpc3Q7CS8qIHNj
YXR0ZXItZ2F0aGVyIGxpc3QgcG9pbnRlciAqLw0KIHVuc2lnbmVkIGludAlz
Z2NvdW50OwkJLyogc2cgY291bnRlciAqLw0KK2NoYXIgKmJ1ZjsNCiANCiBy
dHJjKDEpDQogCWogPSBpbmIocWJhc2UgKyA2KTsNCkBAIC0zOTEsNyArMzky
LDggQEANCiAJCQkJCVJFRzA7DQogCQkJCQlyZXR1cm4gKChxYWJvcnQgPT0g
MSA/IERJRF9BQk9SVCA6IERJRF9SRVNFVCkgPDwgMTYpOw0KIAkJCQl9DQot
CQkJCWlmIChxbF9wZG1hKHBoYXNlLCBzZ2xpc3QtPmFkZHJlc3MsIHNnbGlz
dC0+bGVuZ3RoKSkNCisJCQkJYnVmID0gcGFnZV9hZGRyZXNzKHNnbGlzdC0+
cGFnZSkgKyBzZ2xpc3QtPm9mZnNldDsNCisJCQkJaWYgKHFsX3BkbWEocGhh
c2UsIGJ1Ziwgc2dsaXN0LT5sZW5ndGgpKQ0KIAkJCQkJYnJlYWs7DQogCQkJ
CXNnbGlzdCsrOw0KIAkJCX0NCg==
--1590404226-2114864498-1014202837=:2600--
