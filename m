Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUDSWi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUDSWi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUDSWi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:38:58 -0400
Received: from smtp.gentoo.org ([128.193.0.39]:20420 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262045AbUDSWiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:38:54 -0400
From: Jason Cox <steel300@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: Change number of tty devices
Organization: Gentoo
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__19_Apr_2004_17:38:52_-0500_081f5180"
Message-Id: <E1BFhPh-00027s-IL@smtp.gentoo.org>
Date: Mon, 19 Apr 2004 22:38:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__19_Apr_2004_17:38:52_-0500_081f5180
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all,

Often, I have wondered what the need for 64 tty devices in /dev is. I began tinkering with the code and am wondering why it's not user configurable. I came up with a quick patch to add it as an option under drivers/char/Kconfig. I also made a lower bound of 12. If this is an idea worth pursuing, please let me know. If this idea has been rejected before, I apologize. What do you think of this idea?

Thanks You,
Jason Cox


--Multipart_Mon__19_Apr_2004_17:38:52_-0500_081f5180
Content-Type: application/octet-stream;
 name="config_tty_devices.patch"
Content-Disposition: attachment;
 filename="config_tty_devices.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIGxpbnV4LTIuNi41L2RyaXZlcnMvY2hhci9LY29uZmlnIGxpbnV4LTIuNi42X3Jj
MS1sb3ZlMS9kcml2ZXJzL2NoYXIvS2NvbmZpZwotLS0gbGludXgtMi42LjUvZHJpdmVycy9jaGFy
L0tjb25maWcJMjAwNC0wNC0xOSAxNjowMTo1MC4wMDY2MjQyODcgLTA1MDAKKysrIGxpbnV4LTIu
Ni42X3JjMS1sb3ZlMS9kcml2ZXJzL2NoYXIvS2NvbmZpZwkyMDA0LTA0LTE5IDE2OjM5OjAxLjg3
NzEzODEzMyAtMDUwMApAQCAtNTcsNiArNTcsMTAgQEAKIAogCSAgSWYgdW5zdXJlLCBzYXkgWS4K
IAorY29uZmlnIE5SX1RUWV9ERVZJQ0VTCisJaW50ICJOdW1iZXIgb2YgdHR5IGRldmljZXMiCisJ
ZGVmYXVsdCA2MworCiBjb25maWcgSFdfQ09OU09MRQogCWJvb2wKIAlkZXBlbmRzIG9uIFZUICYm
ICFTMzkwICYmICFVTQpkaWZmIC11ck4gbGludXgtMi42LjUvaW5jbHVkZS9saW51eC90dHkuaCBs
aW51eC0yLjYuNl9yYzEtbG92ZTEvaW5jbHVkZS9saW51eC90dHkuaAotLS0gbGludXgtMi42LjUv
aW5jbHVkZS9saW51eC90dHkuaAkyMDA0LTA0LTE5IDExOjA0OjE5LjAwMDAwMDAwMCAtMDUwMAor
KysgbGludXgtMi42LjZfcmMxLWxvdmUxL2luY2x1ZGUvbGludXgvdHR5LmgJMjAwNC0wNC0xOSAx
Njo1MjoxOS43ODI5MTUwMjkgLTA1MDAKQEAgLTEwLDggKzEwLDEzIEBACiAgKiByZXNpemluZyku
CiAgKi8KICNkZWZpbmUgTUlOX05SX0NPTlNPTEVTIDEgICAgICAgLyogbXVzdCBiZSBhdCBsZWFz
dCAxICovCisjaWYgKENPTkZJR19OUl9UVFlfREVWSUNFUyA8IDExKQogI2RlZmluZSBNQVhfTlJf
Q09OU09MRVMJNjMJLyogc2VyaWFsIGxpbmVzIHN0YXJ0IGF0IDY0ICovCiAjZGVmaW5lIE1BWF9O
Ul9VU0VSX0NPTlNPTEVTIDYzCS8qIG11c3QgYmUgcm9vdCB0byBhbGxvY2F0ZSBhYm92ZSB0aGlz
ICovCisjZWxzZQorI2RlZmluZSBNQVhfTlJfQ09OU09MRVMgQ09ORklHX05SX1RUWV9ERVZJQ0VT
CisjZGVmaW5lIE1BWF9OUl9VU0VSX0NPTlNPTEVTIENPTkZJR19OUl9UVFlfREVWSUNFUworI2Vu
ZGlmCiAJCS8qIE5vdGU6IHRoZSBpb2N0bCBWVF9HRVRTVEFURSBkb2VzIG5vdCB3b3JrIGZvcgog
CQkgICBjb25zb2xlcyAxNiBhbmQgaGlnaGVyIChzaW5jZSBpdCByZXR1cm5zIGEgc2hvcnQpICov
CiAK

--Multipart_Mon__19_Apr_2004_17:38:52_-0500_081f5180--
