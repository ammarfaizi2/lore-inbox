Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274035AbRISLgA>; Wed, 19 Sep 2001 07:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274037AbRISLfu>; Wed, 19 Sep 2001 07:35:50 -0400
Received: from ns.ithnet.com ([217.64.64.10]:54532 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S274035AbRISLfm>;
	Wed, 19 Sep 2001 07:35:42 -0400
Date: Wed, 19 Sep 2001 13:36:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compile Problem in 2.4.10-pre12
Message-Id: <20010919133602.664a6d5a.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

What is this:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.10-pre12; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.10-pre12/kernel/drivers/net/ppp_async.o
depmod:         tty_register_ldisc
depmod: *** Unresolved symbols in
/lib/modules/2.4.10-pre12/kernel/drivers/net/ppp_synctty.o
depmod:         tty_register_ldisc

?

System.map says:
c017a478 T tty_register_ldisc

so symbol should be there, or not?

Regards,
Stephan
