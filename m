Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318411AbSGYLSF>; Thu, 25 Jul 2002 07:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318412AbSGYLSF>; Thu, 25 Jul 2002 07:18:05 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:44207 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318411AbSGYLSE>; Thu, 25 Jul 2002 07:18:04 -0400
Message-ID: <3D3FDF14.C677245F@wanadoo.fr>
Date: Thu, 25 Jul 2002 13:20:52 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.28 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the messages :

if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/usr/src/linux/debian/tmp-image -r 2.5.28; fi
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.28/kernel/drivers/input/gameport/gameport.o
depmod: 	cli
depmod: 	restore_flags
depmod: 	save_flags
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.28/kernel/drivers/input/joystick/analog.o
depmod: 	cli
depmod: 	restore_flags
depmod: 	save_flags
make[2]: *** [_modinst_post] Erreur 1
make[2]: Leaving directory `/usr/src/kernel-source-2.5.28'
make[1]: *** [real_stamp_image] Erreur 2
make[1]: Leaving directory `/usr/src/kernel-source-2.5.28'


-----

Regards
	Jean-Luc

(I'm not on the list)
