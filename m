Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136380AbREIMrn>; Wed, 9 May 2001 08:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136381AbREIMrd>; Wed, 9 May 2001 08:47:33 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:53124 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S136380AbREIMrU>; Wed, 9 May 2001 08:47:20 -0400
Message-ID: <3AF93B78.A55581E9@wanadoo.fr>
Date: Wed, 09 May 2001 14:43:36 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac6 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.xx ? messages related to parport printer ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've an Epson Stylus Color 500 and at boot time I've the following
messages :

with 2.2.20pre (and so well with 2.2.xx) :
------------------------------------------
May  9 13:14:54 debian-f5ibh kernel: parport0: PC-style at 0x378
(0x778), irq 7 [SPP,ECP,ECPEPP,ECPPS2]
May  9 13:14:59 debian-f5ibh kernel: parport0: Unspecified, EPSON Styl
May  9 13:14:59 debian-f5ibh kernel: lp0: using parport0
(interrupt-driven).

With 2.4.4-ac6 and 2.4.xx, I get :
----------------------------------
May  9 14:19:42 debian-f5ibh kernel: parport0: PC-style at 0x378
(0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
May  9 14:19:42 debian-f5ibh kernel: parport0: cpp_mux:
aa55f00f52ad51(b8)
May  9 14:19:42 debian-f5ibh kernel: parport0: cpp_daisy: aa5500ff87(b8)

May  9 14:19:42 debian-f5ibh kernel: parport0: assign_addrs:
aa5500ff87(b8)
May  9 14:19:44 debian-f5ibh kernel: parport0: Printer, EPSON Stylus
COLOR 500
May  9 14:19:44 debian-f5ibh kernel: lp0: using parport0
(interrupt-driven).


... parport0: Unspecified, EPSON Styl
why is the message truncated -------^  ?
what means "Unspecified"               ?

---------
Regards
                Jean-Luc


