Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281234AbRKPIUr>; Fri, 16 Nov 2001 03:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281235AbRKPIUg>; Fri, 16 Nov 2001 03:20:36 -0500
Received: from web10302.mail.yahoo.com ([216.136.130.80]:49702 "HELO
	web10302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281234AbRKPIUZ>; Fri, 16 Nov 2001 03:20:25 -0500
Message-ID: <20011116082013.23833.qmail@web10302.mail.yahoo.com>
Date: Fri, 16 Nov 2001 09:20:13 +0100 (CET)
From: =?iso-8859-1?q?Marco=20Schwarz?= <mschwarz_contron@yahoo.de>
Subject: Machine hangs when booting from NFS server
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I got a serious problem when booting my diskless
clients:

Sometimes it hangs at

<5>Sending BOOTP requests . OK
<4>IP-Config: Got BOOTP answer from 192.168.0.235, my
address is 192.168.0.110
<4>IP-Config: Complete:
<4>      device=eth0, addr=192.168.0.110,
mask=255.255.255.0, gw=255.255.255.255,
<4>     host=192.168.0.110, domain=,
nis-domain=(none),
<4>     bootserver=192.168.0.235,
rootserver=192.168.0.235,
rootpath=/netclients/192.168.0.110,rsize=8192,wsize=8192
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<5>ds: no socket drivers loaded!
<5>Looking up port of RPC 100003/2 on 192.168.0.235
^^^^^^

It will get a timeout and after that it cannot mount
its NFS root.
It happens about 50% of the time ... and sometimes its
working just fine.

Kernel version is 2.4.9.

Somebody know what could cause this ?

Thanks,

Marco Schwarz

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Ihre E-Mail noch individueller? - http://domains.yahoo.de
