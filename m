Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVJMSYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVJMSYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVJMSYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:24:51 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:21434 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932151AbVJMSYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:24:50 -0400
Message-ID: <434EA63F.10306@g-house.de>
Date: Thu, 13 Oct 2005 20:23:59 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: johnpol@2ka.mipt.ru
Subject: [PATCH] Dallas's 1-wire bus compile error (again)
Content-Type: multipart/mixed;
 boundary="------------070505050303060906040608"
X-Antivirus: avast! (VPS 0539-6, 02.10.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070505050303060906040608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,

playing around with "make randconfig" (don't ask :)), i noticed the
driver for the "Dallas's 1-wire bus" does not compile when CONFIG_NET is 
disabled.

this was discussed earlier in

   http://www.ussg.iu.edu/hypermail/linux/kernel/0408.1/1764.html

but the discussion ended up in arguing about using "depends" over 
"select" and the actual fix was forgotten i think.

Signed-off-by: Christian Kujau <evil@g-house.de>

thanks,
Christian.
-- 
BOFH excuse #446:

Mailer-daemon is busy burning your message in hell.

--------------070505050303060906040608
Content-Type: text/plain;
 name="dallas-1-wire_compile-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dallas-1-wire_compile-fix.diff"

LS0tIGxpbnV4LTIuNi9kcml2ZXJzL3cxL0tjb25maWcub3JpZwkyMDA1LTEwLTEzIDIwOjA5
OjQ0LjgxMzk4NjY5OCArMDIwMAorKysgbGludXgtMi42L2RyaXZlcnMvdzEvS2NvbmZpZwky
MDA1LTEwLTEzIDIwOjEwOjIxLjYxMzQ2MDE1MyArMDIwMApAQCAtMiw2ICsyLDcgQEAgbWVu
dSAiRGFsbGFzJ3MgMS13aXJlIGJ1cyIKIAogY29uZmlnIFcxCiAJdHJpc3RhdGUgIkRhbGxh
cydzIDEtd2lyZSBzdXBwb3J0IgorCWRlcGVuZHMgb24gTkVUCiAJLS0taGVscC0tLQogCSAg
RGFsbGFzJ3MgMS13aXJlIGJ1cyBpcyB1c2VmdWxsIHRvIGNvbm5lY3Qgc2xvdyAxLXBpbiBk
ZXZpY2VzCiAJICBzdWNoIGFzIGlCdXR0b25zIGFuZCB0aGVybWFsIHNlbnNvcnMuCg==
--------------070505050303060906040608--
