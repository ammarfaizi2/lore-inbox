Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVCPNk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVCPNk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVCPNjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:39:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:23193 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262592AbVCPNi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:38:26 -0500
Date: Wed, 16 Mar 2005 14:39:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: smfrench@austin.rr.com, linux-kernel@vger.kernel.org
Subject: [PATCH][7/7] cifs: file.c cleanups in incremental bits - condense
 an 'if () else if ()' block.
Message-ID: <Pine.LNX.4.62.0503161436270.3141@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-968154991-1110980356=:3141"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-968154991-1110980356=:3141
Content-Type: TEXT/PLAIN; charset=US-ASCII


This (attached) patch shortens an 'if () else if ()' block in 
cifs_partialpagewrite

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


-- 
Jesper Juhl


--8323328-968154991-1110980356=:3141
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=fs_cifs_file-cleanups-3-condense_if_else.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0503161439160.3141@dragon.hyggekrogen.localhost>
Content-Description: fs_cifs_file-cleanups-3-condense_if_else.patch
Content-Disposition: attachment; filename=fs_cifs_file-cleanups-3-condense_if_else.patch

ZGlmZiAtdXAgbGludXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYy53aXRo
X3BhdGNoXzcgbGludXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYw0KLS0t
IGxpbnV4LTIuNi4xMS1tbTMvZnMvY2lmcy9maWxlLmMud2l0aF9wYXRjaF83
CTIwMDUtMDMtMTYgMTM6NDI6MzEuMDAwMDAwMDAwICswMTAwDQorKysgbGlu
dXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYwkyMDA1LTAzLTE2IDEzOjQz
OjMxLjAwMDAwMDAwMCArMDEwMA0KQEAgLTkwNyw5ICs5MDcsNyBAQCBzdGF0
aWMgaW50IGNpZnNfcGFydGlhbHBhZ2V3cml0ZShzdHJ1Y3QgDQogCXN0cnVj
dCBsaXN0X2hlYWQgKnRtcDsNCiAJc3RydWN0IGxpc3RfaGVhZCAqdG1wMTsN
CiANCi0JaWYgKCFtYXBwaW5nKQ0KLQkJcmV0dXJuIC1FRkFVTFQ7DQotCWVs
c2UgaWYgKCFtYXBwaW5nLT5ob3N0KQ0KKwlpZiAoIW1hcHBpbmcgfHwgIW1h
cHBpbmctPmhvc3QpDQogCQlyZXR1cm4gLUVGQVVMVDsNCiANCiAJaW5vZGUg
PSBwYWdlLT5tYXBwaW5nLT5ob3N0Ow0K

--8323328-968154991-1110980356=:3141--
