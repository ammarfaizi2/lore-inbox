Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVCXBqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVCXBqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVCXBqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:46:23 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:30182 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262331AbVCXBqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:46:18 -0500
Subject: apm poweroff bug
From: "Shawn Smith" <shawn.smith@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Mar 2005 17:46:14 -0800
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1111628774.8c93a03cshawn.smith@myrealbox.com>
Content-Type: multipart/mixed;
	boundary="------=_ModWebBOUNDARY_8c93a03c_1111628774"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--------=_ModWebBOUNDARY_8c93a03c_1111628774
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After giving a halt command, the system is normal until it gives the powerd=
own message, and then there is a dump of error messages.  

This is on a 'freek box' -- a rebuilt computer at free geek in Portland OR.

We believe that this problem has to do with a bug in power management.  

We are using kernel 2.6.

The attached text file is a parital copy of the system messages that appear=
 after the powerdown message after all other systems have been halted.


Thank you for your time and efforts to maintain the kernel code.


Sincerely,  


Shawn Smith




--------=_ModWebBOUNDARY_8c93a03c_1111628774
Content-Type: text/plain;
	name="apm_kernel_report.txt"
Content-Transfer-Encoding: BASE64
Content-Disposition: attachment;
	filename="apm_kernel_report.txt"

OzsgVGhpcyBidWZmZXIgaXMgZm9yIG5vdGVzIHlvdSBkb24ndCB3YW50IHRvIHNhdmUsIGFuZCBm
b3IgTGlzcCBldmFsdWF0aW9uLgo7OyBJZiB5b3Ugd2FudCB0byBjcmVhdGUgYSBmaWxlLCB2aXNp
dCB0aGF0IGZpbGUgd2l0aCBDLXggQy1mLAo7OyB0aGVuIGVudGVyIHRoZSB0ZXh0IGluIHRoYXQg
ZmlsZSdzIG93biBidWZmZXIuCgogICAgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0OiAgZmRmOCBb
IzFdCgogIFBSRUVNUFQKCk1vZHVsZXMgbGlua2VkIGluOiBhbXAgaXB2NiBscCBhdXRvZnM0IHRz
ZGV2IG1vdXNlZGV2IHBzbW91c2UgcGFycG9ydF9wYyBwYXJwb3J0IGZsb3BweSBldmRldiBwY3Nr
a3IgdWhjaV9oY2Qgb2hjaV9oY2QgZWhjaV9oY2QgdXNiY29yZSBzbmRfZW5zMTM3MSBzbmRfcmF3
bWlkaSBzbmRfc2VxX2RldmljZSBzbmRfcGNtX29zcyBzbmRfbWl4ZXJfb3NzIHNuZF9wY20gc25k
X3BhZ2VfYWxsb2Mgc25kX3RpbWVyIHNuZF9hYzk3X2NvZGVjIHNuZCBzb3VuZGNvcmUgZ2FtZXBv
cnQgODEzOWNwIHBjaV9ob3RwbHVnIGFsaV9hZ3AgYWdwZ2FydCA4MTM5dG9vIG1paSBjYXBhYmls
aXR5IGNvbW1vbmNhcCBpZGVfY2QgY2Ryb20gZ2VucnRjIGlzb2ZzIGV4dDMgamJkIGlkZV9nZW5l
cmljIGlkZV9kaXNrIGFsaW0gMTV4MyBpZGVfY29yZSB1bmljIGZvbnQgdmVzYWZiIGNmYmNvcHlh
cmVhIGNmYmltYmx0IGNmYmZpbGxyZWN0CgpDUFU6ICAwCkVJUDogIDAwYzA6IFs8MDAwMDg5M2Q+
XSBub3QgdGFpbnRlZApFRkxBR1M6ICAwMDAxMDA0NiAgKDIuNi44LTItMzg2KQpFSVAgaXMgYXQg
MHg4OTNkCmVheDowMDAwZmRmYSBlYng6MDAwMDAwMDEgZWN4OjAwMDAwMDAxIGVkeDowMDAwMDAw
MCAKZXNpOmM4OWY4MDI2IGVkaTowMDAwMDIwMiBlcGI6Njc4OTAwMDAgZXNwOmM3NjAxZDk4CmRz
OjAwYzggZXM6MDAwMCBzczowMDY4CgpQcm9jZXNzIGhhbHQgKHBpZDogMjU4MCwgdGhyZWFkaW5m
bz1jNzYwMDAwMCB0YXNrPWM3NGRmNmYwCgpTdGFjazoKIDAwMDBmZGZhICAwMDAwMDIwMiAgYzg5
ZjgwMjYgIDY3ODkwMDAwICBjNzYwMWRiYyAgMDAwMDAwMDEgIDAwMDAwMDAwICAwMDAwMDAwMQog
MDAwMDUzODAgIDg4OGEwMDQ2ICA4MDI2MDIwMiAgMWRkMDAwMDAgIDAwMDAwMDAxICA1MzgwMDAw
MyAgODIwMjgxZDkgIDgwMjYwMDAwCiAwMDAwYzg5ZiAgMWRmMjY3ODkgIDAwMDFjNzYwICAwMDAw
MDAwMCAgMDAwMzAwMDAgIDUzMDcwMDAwICAwMDAwMDAwMCAgMDAwMDAwMDAKCkNhbGwgVHJhY2U6
CgpbPGM4OWY0MTk0Pl0gYXBtX2Jpb3NfY2FsbF9zaW1wbGUrMHg3MjEvMHhjMyBbYXBtXQpbPGM4
OWY0Mjk1Pl0gYXBtX3Bvd2VyX29mZisweDM0LzB4M2IgW2FwbV0KWzxjODlmNDJiND5dIHByaW50
aysweGZiLzB4MTFiCls8YzAxMTIyMGI+XSBtYWNoaW5lX3Bvd2VyX29mZisweGIvMHhjCls8YzAx
MjJhODY+XSBzeXNfcmVib290KzB4MTZhLzB4Mjk3Cls8YzAyNGQzY2Q+XSBzY2hlZHVsZSsweDIx
Zi8weDNlNgpbPGMwMjRkNTQ4Pl0gc2NoZWR1bGUrMHgzYTQvMHgzZTYKWzxjMDI0ZDViMz5dIHBy
ZWVtcHRfY2hlZHVsZSsweDI5LzB4NDEKWzxjMDEyMDhmZj5dIGtpbGxfcHJvY19pbmZvKzB4NDEv
MHg0NgpbPGMwMTIxZDYzPl0gc3lzX2tpbGwrMHg0ZS8weDU1Cls8YzAxZGE3Mzc+XSBibGtkZXZf
aW9jdGwrMHgzNDYvMHgzNWIKWzxjMDE1M2E3Yz5dIGJsb2NrX2lvY3RsKzB4MWEvMHgxZQpbPGMw
MTUzYTQxPl0gc3lzX2lvY3RsKzB4MWNkLzB4MjE0Cls8YzAxNTNhN2M+XSBzeXNfaW9jdGwrMHgy
MDgvMHgyMTQKWzxjMDEwNWY5Nz5dIHN5c2NhbGxfY2FsbCsweDcvMHhiCgpDb2RlOiAgQmFkIEVJ
UCB2YWx1ZQogICA8Nj5ub3RlOiBoYWx0IFsyNTgwXSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50
IDIKICBiYWQgc2NoZWR1bGluZyB3aGlsZSBhdG9taWMhCgpbPGMwMjRkMWUwPl0gc2NoZWR1bGUr
MHgzYy8weDNlNgpbPGMwMTM4MTkxPl0gdW5tYXBfdm1hcysweGUwLzB4MWNmCls8YzAxMzgyMTM+
XSB1bm1hcF92bWFzKzB4MTYyLzB4MWNmCgo=

--------=_ModWebBOUNDARY_8c93a03c_1111628774--

