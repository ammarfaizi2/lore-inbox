Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRBLQKe>; Mon, 12 Feb 2001 11:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131093AbRBLQKY>; Mon, 12 Feb 2001 11:10:24 -0500
Received: from cm-24-142-168-193.lawton.ispchannel.com ([24.142.168.193]:46340
	"EHLO localhost") by vger.kernel.org with ESMTP id <S130449AbRBLQKS>;
	Mon, 12 Feb 2001 11:10:18 -0500
Date: Mon, 12 Feb 2001 10:13:18 -0600
To: linux-kernel@vger.kernel.org
Subject: 2.2.19ac-pre9 lo interface Broke
Message-ID: <20010212101318.A6980@home-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure how else to put it...

$ sudo ifup lo
SIOCSIFADDR: Bad file descriptor
lo: unknown interface: Bad file descriptor
lo: unknown interface: Bad file descriptor

$ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:A0:C9:D9:21:B9
          inet addr:24.142.168.193  Bcast:255.255.255.255 Mask:255.255.254.0
		  UP BROADCAST RUNNING  MTU:1500  Metric:1
		  RX packets:8223 errors:0 dropped:0 overruns:0 frame:0
		  TX packets:7373 errors:0 dropped:0 overruns:0 carrier:0
		  collisions:3 txqueuelen:100
		  RX bytes:8241275 (7.8 Mb)  TX bytes:2271020 (2.1 Mb)
		  Interrupt:15 Base address:0x1000
		
Works just fine same box, same config with 2.2.18ac-pre24.

Debian tools: ifupdown 0.6.4-3 (ifup ifdown)
			  net-tools 1.58-1 (ifconfig)

Intel Etherexpress 10/100 eepro100
CONFIG_EEXPRESS_PRO100=y

Any ideas?

Please CC any replies.

Gordon Sadler
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
