Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269971AbRHSEao>; Sun, 19 Aug 2001 00:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269974AbRHSEae>; Sun, 19 Aug 2001 00:30:34 -0400
Received: from c003-h000.c003.snv.cp.net ([209.228.32.214]:20619 "HELO
	c003.snv.cp.net") by vger.kernel.org with SMTP id <S269971AbRHSEa0> convert rfc822-to-8bit;
	Sun, 19 Aug 2001 00:30:26 -0400
X-Sent: 19 Aug 2001 04:30:34 GMT
Subject: Problem: kernel hang up after restart X and use i810 with DRM 4.1
	aceleration.
From: Tigrux <tigrux@avantel.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12 (Preview Release)
Date: 18 Aug 2001 23:31:11 -0500
Message-Id: <998195473.10645.21.camel@Terror.comp99>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use kernel-2.4.8-ac7, but the problem is general to kernel more newer
that 2.4.8-ac5 (all kernel with native support to DRM 4.1 and XFree
4.1).

I start my X sessione, then I run any OpenGL programm (Heavy Gear,
TuxRacer, Gears, etc), the I restart X, and the... KERNEL DIE!!

In another hand, if I start X, and do not use OpenGL programms, and then
restart X, the kernel do not die.

I'm using:
  XFree86 4.1
  Pentium 3 Coppermine 550MHz, 100MHz bus.
  256 MB swap.
  256 DIMM RAM.
  i810 acelerator card on board.

I think the problem is related to the implementation of DRM.

-- End of report

-- BEGIN ver_linux_info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux Terror.comp99 2.4.8-ac7 #4 sáb ago 18 01:37:06 CDT 2001 i686
unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.0.24
util-linux             2.10o
mount                  2.10o
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ppp_deflate ymf724 audiobuf opl3 uart401 pnp midi
ac97 soundbase sndshield ac97_codec imm
-- END ver_linux_info

  
  

