Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUJ0Vt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUJ0Vt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUJ0Vsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:48:53 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:59063 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262942AbUJ0Vni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:43:38 -0400
Message-ID: <51413.82.82.120.6.1098913408.squirrel@82.82.120.6>
Date: Wed, 27 Oct 2004 23:43:28 +0200 (CEST)
Subject: 2.6.10-rc1-mm1 reiser4: scheduling while atomic:
From: jan@unigate.homeip.net
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041027234328_53682"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041027234328_53682
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,
I'm getting "scheduling while atomic" messages after running
2.6.10-rc1-mm1 for a while. I have attached my dmesg output.

uname -a:
Linux deepspace 2.6.10-rc1-mm1 #10 Wed Oct 27 20:26:56 CEST 2004 x86_64
AMD Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux

------=_20041027234328_53682
Content-Type: application/gzip; name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.gz"

H4sICI0UgEEAA2RtZXNnAO3SzU7jMBQG0D1P0X0XxOk/Qt3MK8w+MolbImXaKkmhUsW7TwoMogge
YKTjTRaxP997fXb1qdjUTRpPs5fR/eZ9xSxLD9Vsuj7ftanuUjv99y3a1KTYpXHIhgM3o7f1cXCZ
hfnmYZWvz0WxORz78Wr5cv03zUJan4crD0XZ7C9B+fz7oEmYribr85DyWmFXdH17LPtxCLPrzEk+
reL6XO2LdKr78TzLfwjMl3Hzum/b7o+Ht935cvElrczLIW2b+qKrt7vYFP2+qFJTP6V26Hr+Q7VZ
tZxOXsPfTo3DfPK19ZQt1uenTVc8t3U/dL5a/ZC1CdkwwkNs425fVx+JYdjelY+pOjb1bjt6fhzG
Mor9/k9d3o1id5udhle5rHAb5nlY3dz8ik0z+t3GMt19uiCPs7BYrc/vWZc3CFe15nE+ncwuj1jt
n3cf5S6+KTdmIeSLtPxE5TK6dCqbYzfMrIhlmbpuPPtubvHSa3V1+N1XcdyRSSaZZJJJJplkkkkm
mWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplk
kkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJ
JplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZ
ZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSS
SSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkm
mWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplk
kkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJ
JplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZ
ZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSS
SSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkm
mWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplk
kkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJ
JplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZ
ZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSS
SSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkm
mWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplk
kkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJ
JplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZ
ZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSS
SSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkm
mWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplkkkkmmWSSSSaZZJJJJplk
kvk/yvwLa/OoiOHTAwA=
------=_20041027234328_53682--


