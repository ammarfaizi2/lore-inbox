Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSFJHKn>; Mon, 10 Jun 2002 03:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFJHKm>; Mon, 10 Jun 2002 03:10:42 -0400
Received: from [210.19.28.11] ([210.19.28.11]:19331 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S316397AbSFJHKk> convert rfc822-to-8bit; Mon, 10 Jun 2002 03:10:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Corporal Pisang <corporal_pisang@counter-strike.com.my>
Organization: Counter-Strike.com.my
To: linux-kernel@vger.kernel.org
Subject: 2.5.21 make modules_install error
Date: Mon, 10 Jun 2002 15:17:00 +0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206101517.00971.corporal_pisang@counter-strike.com.my>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I get this error at the end of #make modules_install

make[1]: Entering directory `/usr/src/linux/arch/i386/mm'
make[1]: Leaving directory `/usr/src/linux/arch/i386/mm'
make[1]: Entering directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Entering directory `/usr/src/linux/arch/i386/pci'
make[1]: Leaving directory `/usr/src/linux/arch/i386/pci'
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.21; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.21/kernel/drivers/net/bsd_comp.o
depmod:         vmalloc
depmod: *** Unresolved symbols in 
/lib/modules/2.5.21/kernel/drivers/net/ppp_deflate.o
depmod:         vmalloc
depmod: *** Unresolved symbols in /lib/modules/2.5.21/kernel/fs/isofs/isofs.o
depmod:         vmalloc
depmod: *** Unresolved symbols in 
/lib/modules/2.5.21/kernel/net/ipv4/netfilter/ip_tables.o
depmod:         vmalloc
depmod: *** Unresolved symbols in 
/lib/modules/2.5.21/kernel/net/ipv4/netfilter/iptable_nat.o
depmod:         vmalloc
depmod: *** Unresolved symbols in 
/lib/modules/2.5.21/kernel/net/ipv6/netfilter/ip6_tables.o
depmod:         vmalloc
depmod: *** Unresolved symbols in /lib/modules/2.5.21/kernel/sound/core/snd.o
depmod:         vmalloc
depmod: *** Unresolved symbols in /lib/modules/2.5.21/kernel/sound/oss/sound.o
depmod:         vmalloc
depmod: *** Unresolved symbols in /lib/modules/2.5.21/kernel/sound/soundcore.o
depmod:         vmalloc
make: *** [_modinst_post] Error 1


Regards

-Ubaida-
