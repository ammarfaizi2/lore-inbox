Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUDJFus (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 01:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUDJFus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 01:50:48 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:55974 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S261932AbUDJFur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 01:50:47 -0400
Date: Sat, 10 Apr 2004 09:51:37 +0400
From: Kirill Korotaev <kirillx@7ka.mipt.ru>
Reply-To: Kirill Korotaev <kirillx@7ka.mipt.ru>
Organization: SWsoft
X-Priority: 3 (Normal)
Message-ID: <403331971.20040410095137@7ka.mipt.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] memory leak in devpts in 2.4.x
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------11B17CBB26B14559"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------11B17CBB26B14559
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 small memory leak in devpts_read_super() on error path.

 Kirill
 
------------11B17CBB26B14559
Content-Type: application/octet-stream; name="devpts.diff"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="devpts.diff"

LS0tIC4vZnMvZGV2cHRzL2lub2RlLmMuZHB0cwkyMDA0LTA0LTA4IDA4OjM4OjE3LjAwMDAw
MDAwMCArMDQwMAorKysgLi9mcy9kZXZwdHMvaW5vZGUuYwkyMDA0LTA0LTA4IDA4OjQxOjU2
LjAwMDAwMDAwMCArMDQwMApAQCAtMTQzLDEyICsxNDMsMTIgQEAgc3RydWN0IHN1cGVyX2Js
b2NrICpkZXZwdHNfcmVhZF9zdXBlcihzdAogCiAJaWYgKCBkZXZwdHNfcGFyc2Vfb3B0aW9u
cyhkYXRhLHNiaSkgJiYgIXNpbGVudCkgewogCQlwcmludGsoImRldnB0czogY2FsbGVkIHdp
dGggYm9ndXMgb3B0aW9uc1xuIik7Ci0JCWdvdG8gZmFpbF9mcmVlOworCQlnb3RvIGZhaWxf
aW5vZGU7CiAJfQogCiAJaW5vZGUgPSBuZXdfaW5vZGUocyk7CiAJaWYgKCFpbm9kZSkKLQkJ
Z290byBmYWlsX2ZyZWU7CisJCWdvdG8gZmFpbF9pbm9kZTsKIAlpbm9kZS0+aV9pbm8gPSAx
OwogCWlub2RlLT5pX210aW1lID0gaW5vZGUtPmlfYXRpbWUgPSBpbm9kZS0+aV9jdGltZSA9
IENVUlJFTlRfVElNRTsKIAlpbm9kZS0+aV9ibG9ja3MgPSAwOwpAQCAtMTcwLDYgKzE3MCw4
IEBAIHN0cnVjdCBzdXBlcl9ibG9jayAqZGV2cHRzX3JlYWRfc3VwZXIoc3QKIAkKIAlwcmlu
dGsoImRldnB0czogZ2V0IHJvb3QgZGVudHJ5IGZhaWxlZFxuIik7CiAJaXB1dChpbm9kZSk7
CitmYWlsX2lub2RlOgorCWtmcmVlKHNiaS0+aW5vZGVzKTsKIGZhaWxfZnJlZToKIAlrZnJl
ZShzYmkpOwogZmFpbDoK
------------11B17CBB26B14559--

