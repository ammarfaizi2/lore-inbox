Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312459AbSCUTLy>; Thu, 21 Mar 2002 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSCUTLd>; Thu, 21 Mar 2002 14:11:33 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:44172 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312457AbSCUTL1>; Thu, 21 Mar 2002 14:11:27 -0500
Message-ID: <3C9A3043.4AA87A26@wanadoo.fr>
Date: Thu, 21 Mar 2002 20:10:59 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 make modules_install failed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Leaving directory `/usr/src/kernel-sources-2.5.7/arch/i386/lib'
cd /lib/modules/2.5.7; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.7; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.7/kernel/sound/oss/sound.o
depmod: 	virt_to_bus_not_defined_use_pci_map
make: *** [_modinst_post] Error 1

-----
Regards
	Jean-Luc
