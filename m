Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbRFPMrx>; Sat, 16 Jun 2001 08:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbRFPMre>; Sat, 16 Jun 2001 08:47:34 -0400
Received: from altair.alt.iph.ras.ru ([194.67.87.171]:36104 "EHLO
	altair.office.altlinux.ru") by vger.kernel.org with ESMTP
	id <S264619AbRFPMrW>; Sat, 16 Jun 2001 08:47:22 -0400
Date: Sat, 16 Jun 2001 16:47:03 +0400
From: Konstantin Volckov <goldhead@altlinux.ru>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <20010616164703.22d0a90f.goldhead@altlinux.ru>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i586-alt-linux)
Organization: ALT Linux
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__16_Jun_2001_16:47:03_+0400_08290ec0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__16_Jun_2001_16:47:03_+0400_08290ec0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

There're a problem in <linux/capatibility.h>. In this file included
<linux/fs.h>, but this include is'nt ifdef'ed with __KERNEL__ and (for
example) samba can't be compiled with kernel 2.4 headers. Here is the
patch, that solve this problem.

-- 
Good luck,
Konstantin

--Multipart_Sat__16_Jun_2001_16:47:03_+0400_08290ec0
Content-Type: application/octet-stream;
 name="linux-2.4.5-ac15-lcap.patch"
Content-Disposition: attachment;
 filename="linux-2.4.5-ac15-lcap.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvY2FwYWJpbGl0eS5oX29sZAlUaHUgSnVuIDE0IDEzOjE5
OjA4IDIwMDEKKysrIGxpbnV4L2luY2x1ZGUvbGludXgvY2FwYWJpbGl0eS5oCVRodSBKdW4gMTQg
MjA6NDY6MDcgMjAwMQpAQCAtMTQsNyArMTQsNiBAQAogI2RlZmluZSBfTElOVVhfQ0FQQUJJTElU
WV9ICiAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgotI2luY2x1ZGUgPGxpbnV4L2ZzLmg+CiAK
IC8qIFVzZXItbGV2ZWwgZG8gbW9zdCBvZiB0aGUgbWFwcGluZyBiZXR3ZWVuIGtlcm5lbCBhbmQg
dXNlcgogICAgY2FwYWJpbGl0aWVzIGJhc2VkIG9uIHRoZSB2ZXJzaW9uIHRhZyBnaXZlbiBieSB0
aGUga2VybmVsLiBUaGUKQEAgLTI3OCw2ICsyNzcsNyBAQAogI2RlZmluZSBDQVBfTEVBU0UgICAg
ICAgICAgICAyOAogCiAjaWZkZWYgX19LRVJORUxfXworI2luY2x1ZGUgPGxpbnV4L2ZzLmg+CiAv
KiAKICAqIEJvdW5kaW5nIHNldAogICovCg==

--Multipart_Sat__16_Jun_2001_16:47:03_+0400_08290ec0--
