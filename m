Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJBRCW>; Tue, 2 Oct 2001 13:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275851AbRJBRCM>; Tue, 2 Oct 2001 13:02:12 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:45828 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S275778AbRJBRB6>;
	Tue, 2 Oct 2001 13:01:58 -0400
From: Mark Hindley <mark@hindley.uklinux.net>
Message-ID: <15289.60336.765914.654516@titan.home.hindley.uklinux.net>
Date: Tue, 2 Oct 2001 17:30:40 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-thinkpad@topica.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PLIP on thinkpad 560E
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anybody know if PLIP works on a thinkpad 560E. I can't get it to!

I am using 2.4.10.

The packets are received, but the sending seems to fail:

Logs:
Oct  2 17:18:42 localhost kernel: plip0: transmit timeout(1,87)
Oct  2 17:18:43 localhost kernel: plip0: transmit timeout(1,87)

ifconfig:
plip0       Link encap:VJ Serial Line IP
          inet addr:192.168.1.2  P-t-P:192.168.1.1  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1596  Metric:1
          RX packets:42 errors:0 dropped:0 overruns:0 frame:0
             compressed:0
          TX packets:0 errors:42 dropped:0 overruns:0 carrier:42
          collisions:0 compressed:0 txqueuelen:10          

I have the parallel port set to ECP. I have tried reversing the
connection wire!

Any suggestions? It has been suggested/mentioned that the port is butchered in
some way and won't do plip. Is this true? Does anyone know the detail?


Thanks,


Mark
