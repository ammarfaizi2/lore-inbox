Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUBRNZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUBRNZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:25:16 -0500
Received: from web40104.mail.yahoo.com ([66.218.78.38]:44979 "HELO
	web40104.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264434AbUBRNZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:25:10 -0500
Message-ID: <20040218132502.49545.qmail@web40104.mail.yahoo.com>
Date: Wed, 18 Feb 2004 05:25:02 -0800 (PST)
From: Nikolay Nikolov <dobrev666@yahoo.com>
Subject: als4000 joystic problem with 2.6.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1820280401-1077110702=:48577"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1820280401-1077110702=:48577
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

I have als4000 sound card and when i run kernel 2.6.3
and try to load snd-als4000 module it says:
snd_als4000: falsely claims to have parameter
joystick_port
A have not configured CONFIG_GAMEPORT
I think this happens because there are not
#ifdef SUPPORT_JOYSTICK
...
#endif
in als4000.c when module params are declared.
I attached a patch

__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
--0-1820280401-1077110702=:48577
Content-Type: application/octet-stream; name="linux.patch"
Content-Transfer-Encoding: base64
Content-Description: linux.patch
Content-Disposition: attachment; filename="linux.patch"

LS0tIG15bGludXgtMi42LjMvc291bmQvcGNpL2FsczQwMDAuYwkyMDA0LTAy
LTE4IDE1OjEzOjQwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgvc291bmQv
cGNpL2FsczQwMDAuYwkyMDA0LTAyLTE4IDE0OjI5OjIzLjAwMDAwMDAwMCAr
MDIwMApAQCAtOTksOSArOTksMTEgQEAKIE1PRFVMRV9QQVJNKGVuYWJsZSwg
IjEtIiBfX01PRFVMRV9TVFJJTkcoU05EUlZfQ0FSRFMpICJpIik7CiBNT0RV
TEVfUEFSTV9ERVNDKGVuYWJsZSwgIkVuYWJsZSBBTFM0MDAwIHNvdW5kY2Fy
ZC4iKTsKIE1PRFVMRV9QQVJNX1NZTlRBWChlbmFibGUsIFNORFJWX0lOREVY
X0RFU0MpOworI2lmZGVmIFNVUFBPUlRfSk9ZU1RJQ0sKIE1PRFVMRV9QQVJN
KGpveXN0aWNrX3BvcnQsICIxLSIgX19NT0RVTEVfU1RSSU5HKFNORFJWX0NB
UkRTKSAiaSIpOwogTU9EVUxFX1BBUk1fREVTQyhqb3lzdGlja19wb3J0LCAi
Sm95c3RpY2sgcG9ydCBhZGRyZXNzIGZvciBBTFM0MDAwIHNvdW5kY2FyZC4g
KDAgPSBkaXNhYmxlZCkiKTsKIE1PRFVMRV9QQVJNX1NZTlRBWChqb3lzdGlj
a19wb3J0LCBTTkRSVl9FTkFCTEVEKTsKKyNlbmRpZgogCiAjZGVmaW5lIGNo
aXBfdCBzYl90CiAK

--0-1820280401-1077110702=:48577--
