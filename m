Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264502AbRFJG2W>; Sun, 10 Jun 2001 02:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264503AbRFJG2L>; Sun, 10 Jun 2001 02:28:11 -0400
Received: from web13906.mail.yahoo.com ([216.136.175.69]:31751 "HELO
	web13906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264502AbRFJG2A>; Sun, 10 Jun 2001 02:28:00 -0400
Message-ID: <20010610062755.64407.qmail@web13906.mail.yahoo.com>
Date: Sat, 9 Jun 2001 23:27:55 -0700 (PDT)
From: Mr Miles T Lane <miles_lane@yahoo.com>
Subject: 2.4.5-ac12 -- Unresolved symbols in drivers/net/wan/comx.o -- "proc_get_inode"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i
-r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F
System.map  2.4.5-ac12; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-ac12/kernel/drivers/net/wan/comx.o
depmod: 	proc_get_inode


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
