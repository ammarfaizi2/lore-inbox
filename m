Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274089AbRISPXd>; Wed, 19 Sep 2001 11:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274092AbRISPXY>; Wed, 19 Sep 2001 11:23:24 -0400
Received: from kiln.isn.net ([198.167.161.1]:38674 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S274089AbRISPXL>;
	Wed, 19 Sep 2001 11:23:11 -0400
Message-ID: <3BA8B813.B017592@isn.net>
Date: Wed, 19 Sep 2001 12:21:55 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]2.4.10p12 net/netsyms.c -- unresolved symbol 
 tty_register_ldisc
Content-Type: multipart/mixed;
 boundary="------------8857616C78551FD0E30E8479"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8857616C78551FD0E30E8479
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached are some others, Mohammad's one liner patch is unreadable on
Geocrawler.
My modules.conf is correct, I do need a readable form of that patch.
pls cc me.
Garst
--------------8857616C78551FD0E30E8479
Content-Type: text/plain; charset=us-ascii;
 name="modules_install.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules_install.log"

cd /lib/modules/2.4.10-pre12; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.10-pre12; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.10-pre12/kernel/drivers/net/irda/irtty.o
depmod: 	tty_register_ldisc
depmod: *** Unresolved symbols in /lib/modules/2.4.10-pre12/kernel/drivers/net/ppp_async.o
depmod: 	tty_register_ldisc
depmod: *** Unresolved symbols in /lib/modules/2.4.10-pre12/kernel/drivers/net/slip.o
depmod: 	tty_register_ldisc

--------------8857616C78551FD0E30E8479--

