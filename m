Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129956AbRAQDDP>; Tue, 16 Jan 2001 22:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRAQDDG>; Tue, 16 Jan 2001 22:03:06 -0500
Received: from adsl-63-206-97-82.dsl.snfc21.pacbell.net ([63.206.97.82]:23800
	"EHLO mail.corp124.com") by vger.kernel.org with ESMTP
	id <S129956AbRAQDCt>; Tue, 16 Jan 2001 22:02:49 -0500
Message-ID: <3A650B5B.EE1CCB07@corp124.com>
Date: Tue, 16 Jan 2001 19:02:52 -0800
From: Kostas Nikoloudakis <kostas@corp124.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: eepro100 error messages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Message from syslogd@zeus at Tue Jan 16 00:17:29 2001 ...
zeus kernel: 0000000000000000000000000000000000 to4  0 0  0 00100001001.

Message from syslogd@zeus at Tue Jan 16 00:26:38 2001 ...
zeus kernel: 0:0: 0:0:0: 0: 0:0: 0:0: 0:0: 0:0:0:  0:0:0: 0:0: 0:0: 0
ind.

Message from syslogd@zeus at Tue Jan 16 00:49:15 2001 ...
zeus kernel: 00001.000000000.000000.000001 ether 1HY i0 >tePHY index 1
register 5 is 41e1.
Hello,
Does anybody know what the exact cause for the following messages is:
Jan 16 00:49:04 cd20 kernel: eth0: card reports no resources. 
Jan 16 00:49:06 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:06 cd20 kernel: eth0: restart the receiver after a possible
hang. 
Jan 16 00:49:06 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:06 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:06 cd20 kernel: eth0: card reports no resources. 
Jan 16 00:49:08 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:08 cd20 kernel: eth0: restart the receiver after a possible
hang. 
Jan 16 00:49:09 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:09 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:09 cd20 kernel: eth0: card reports no resources. 
Jan 16 00:49:09 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:09 cd20 kernel: eth0: restart the receiver after a possible
hang. 
Jan 16 00:49:09 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:09 cd20 kernel: eth0: card reports no resources. 
Jan 16 00:49:12 cd20 kernel:  000ca000. 
Jan 16 00:49:12 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:12 cd20 last message repeated 6 times
Jan 16 00:49:12 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:12 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:13 cd20 last message repeated 15 times
Jan 16 00:49:13 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:13 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:13 cd20 last message repeated 7 times
Jan 16 00:49:13 cd20 kernel: eth0: card reports no resources. 
Jan 16 00:49:13 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:13 cd20 last message repeated 7 times
Jan 16 00:49:13 cd20 kernel:  000ca000. 
Jan 16 00:49:13 cd20 kernel: eth0: can't fill rx buffer (force 1)! 


Hello there,
Does anyone know the cause and a potential fix for the following
error messages reported in syslogd by my eepro100 card?

The machine is running under heavy CPU + memory + network load.
It seems that the card has problems finding the required resources.
Is there a way to "guarantee" that the card will have the necessary
resources even at high loads?

I'm using kernel version 2.2.14.

Thank you,
Sincerely
Kostas Nikoloudakis

Jan 16 00:49:13 cd20 kernel: eth0: card reports no resources. 
Jan 16 00:49:15 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:15 cd20 kernel: eth0: restart the receiver after a possible
hang. 
Jan 16 00:49:15 cd20 kernel: eth0: can't fill rx buffer (force 0)! 
Jan 16 00:49:15 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:15 cd20 last message repeated 6 times
Jan 16 00:49:15 cd20 kernel:  000ca000. 
Jan 16 00:49:15 cd20 kernel: eth0: can't fill rx buffer (force 1)! 
Jan 16 00:49:15 cd20 last message repeated 16 times
Jan 16 00:49:15 cd20 kernel: 00000 t4     
000000000000000020.0020.020002020. 
Jan 16 00:49:15 cd20 kernel: 00001.000000000.000000.000001 ether 1HY i0
>tePHY index 1 register 5 is 41e1.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
