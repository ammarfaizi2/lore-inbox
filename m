Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310209AbSCSG1u>; Tue, 19 Mar 2002 01:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310212AbSCSG1k>; Tue, 19 Mar 2002 01:27:40 -0500
Received: from [210.19.28.11] ([210.19.28.11]:3972 "EHLO dZuRa.Vault-ID.com")
	by vger.kernel.org with ESMTP id <S310209AbSCSG1e>;
	Tue, 19 Mar 2002 01:27:34 -0500
Date: Tue, 19 Mar 2002 14:24:21 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 make modules_install error (oss)
Message-Id: <20020319142421.6359419a.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
cd /lib/modules/2.5.7; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.7; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.7/kernel/sound/oss/sound.o
depmod:         virt_to_bus_not_defined_use_pci_map
make: *** [_modinst_post] Error 1

Regards,

-Ubaida-
