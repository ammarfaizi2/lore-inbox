Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEALXZ>; Wed, 1 May 2002 07:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310224AbSEALXY>; Wed, 1 May 2002 07:23:24 -0400
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:34823 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S310206AbSEALXX>; Wed, 1 May 2002 07:23:23 -0400
Message-Id: <200205011123.AA00059@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Wed, 01 May 2002 20:23:11 +0900
To: linux-kernel@vger.kernel.org
Cc: nakasei@fa.mdis.co.jp
Subject: 2.5.12 compile error ( e100, Alternate Intel driver )
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I compile 2.5.12 without framebuffer console and boot up fine.
First I use EtherExpressPro/100 support ( e100, Altrenate Intel driver ),
but compile error occured. this driver is default.
I change EtherExpressPro/100 support ( eepro100, original Becker driver ),
then compile and boot up fine.

=== compile error EtherExpressPro/100 support ( e100, Altrenate Intel driver ) ===

io_apic.c:221: warning: `move' defined but not used
drivers/net/net.o: In function `e100_diag_config_loopback':
drivers/net/net.o(.text+0x52ff): undefined reference to `e100_phy_reset'
make: *** [vmlinux] Error 1

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
