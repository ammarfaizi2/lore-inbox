Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318712AbSG0IHn>; Sat, 27 Jul 2002 04:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318713AbSG0IHn>; Sat, 27 Jul 2002 04:07:43 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:58789 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318712AbSG0IHm>; Sat, 27 Jul 2002 04:07:42 -0400
Message-ID: <3D425574.231341D1@wanadoo.fr>
Date: Sat, 27 Jul 2002 10:10:28 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cannot build 2.5.29
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've the following error message :

make[3]: Leaving directory `/usr/src/kernel-source-2.5.29/arch/i386/pci'
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/usr/src/linux/debian/tmp-image -r 2.5.29; fi
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.29/kernel/arch/i386/kernel/apm.o
depmod: 	cpu_gdt_table
depmod: 	num_possible_cpus
make[2]: *** [_modinst_post] Erreur 1
make[2]: Leaving directory `/usr/src/kernel-source-2.5.29'
make[1]: *** [real_stamp_image] Erreur 2
make[1]: Leaving directory `/usr/src/kernel-source-2.5.29'

------
Regards
	Jean-Luc
