Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317660AbSGZJl0>; Fri, 26 Jul 2002 05:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317663AbSGZJl0>; Fri, 26 Jul 2002 05:41:26 -0400
Received: from [211.167.76.68] ([211.167.76.68]:54674 "EHLO discovery")
	by vger.kernel.org with ESMTP id <S317660AbSGZJlZ>;
	Fri, 26 Jul 2002 05:41:25 -0400
Date: Fri, 26 Jul 2002 17:45:19 +0800
From: Hu Gang <happy@soul.com.cn>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] bad: schedule() with irqs disabled!
Message-Id: <20020726174519.2c0dedbf.happy@soul.com.cn>
X-Mailer: Sylpheed version 0.7.8claws9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

Oops Report:
Jul 26 17:20:43 discovery kernel: bad: schedule() with irqs disabled!
Jul 26 17:20:43 discovery kernel: c1929d5c c01da040 c1164ac0 c1929d84 c010fe35 00000001 c022cba8 fffffffe
Jul 26 17:20:43 discovery kernel:        c1929d80 00000046 c1929d94 c010fe4b c1164ac0 00000000 c022cba0 c0117c30
Jul 26 17:20:43 discovery kernel:        c1928000 c333d800 c63292a0 00000000 00000246 c019e270 c1928000 c63292a0
Jul 26 17:20:43 discovery kernel: Call Trace: [try_to_wake_up+257/268] [wake_up_process+11/16] [Letext+160/172] [dev_queue_xmit+260/752] [ip_output+238/344]
Jul 26 17:20:43 discovery kernel:    [ip_queue_xmit+930/1260] [tcp_transmit_skb+1082/1436] [tcp_transmit_skb+1257/1436] [default_wake_function+29/52] [tcp_push_one+115/252] [tcp_sendmsg+2637/4340]
Jul 26 17:20:43 discovery kernel:    [__kfree_skb+285/292] [inet_sendmsg+62/68] [sock_sendmsg+111/144] [sock_write+168/180] [vfs_write+148/272] [sys_write+42/60]
Jul 26 17:20:43 discovery kernel:    [syscall_call+7/11] 
------
ver_linux
Linux discovery 2.5.28 #3 ËÄ 7ÔÂ 25 23:47:01 CST 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.34
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12
Modules Loaded         apm soundcore pcnet_cs 8390 crc32 ds yenta_socket pcmcia_core binfmt_misc agpgart rtc unix


-- 
thanks with regards!
hugang.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn

Developer, Debian GNU/Linux 
***********************************
