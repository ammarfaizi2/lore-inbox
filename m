Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRIXMlE>; Mon, 24 Sep 2001 08:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273893AbRIXMky>; Mon, 24 Sep 2001 08:40:54 -0400
Received: from 211-174-51-118.kidc.net ([211.174.51.118]:25349 "EHLO
	mail.wowlinux.com") by vger.kernel.org with ESMTP
	id <S273881AbRIXMkk>; Mon, 24 Sep 2001 08:40:40 -0400
Message-Id: <200109241240.f8OCeor06508@mail.wowlinux.com>
Content-Type: text/plain;
  charset="euc-kr"
From: Kim Yong Il <nalabi@formail.org>
Reply-To: nalabi@formail.org
To: linux-kernel@vger.kernel.org
Subject: Q Logis ioports bug .....
Date: Mon, 24 Sep 2001 21:40:56 +0900
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4000-40ff : Q Logic ISP2200
  4000-40fe : aa

4000-40fe: aa <----- bug?????

----->
[root@localhost /proc]# cat ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1800-18ff : Compaq Computer Corporation Advanced System Management Controller
2000-20ff : Symbios Logic Inc. (formerly NCR) 53c1510
  2000-20ff : sym53c8xx
2400-24ff : Symbios Logic Inc. (formerly NCR) 53c1510 (#2)
  2400-24ff : sym53c8xx
2800-283f : Intel Corporation 82557 [Ethernet Pro 100]
  2800-283f : eepro100
2c00-2cff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
3000-300f : ServerWorks OSB4 IDE Controller
  3000-3007 : ide0
  3008-300f : ide1
4000-40ff : Q Logic ISP2200
  4000-40fe : aa

[root@localhost /proc]# uname -a
Linux localhost.localdomain 2.4.9-0.5 #1 Mon Sep 24 19:24:44 KST 2001 i686 
unknown


-- 
nalabi@formail.org

