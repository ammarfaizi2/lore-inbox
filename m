Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQLMKWr>; Wed, 13 Dec 2000 05:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130879AbQLMKWh>; Wed, 13 Dec 2000 05:22:37 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:65290 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130653AbQLMKWX> convert rfc822-to-8bit; Wed, 13 Dec 2000 05:22:23 -0500
Date: Wed, 13 Dec 2000 10:51:53 +0100
From: Martin Macok <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12 randomly hangs up
Message-ID: <20001213105153.A6624@sarah.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
X-Echelon: GRU NSA GCHQ KGB CIA nuclear conspiration war weapon spy agent
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after 1-3 hours with -test12 system hangs up with
 - no response from mouse
 - no response from keyboard (no sysrq, only sysrq+'b' works ...)
 - no response from network (ICMP, TCP)
 - nothing on console, nothing in logs (ie. nothing interesting or relevant
   to crash).

System was not under load (1 user, X, no swapping ...)

( -test11 was up for 3 weeks with no problems and so do 2.2.17 ... )

slightly modified Red Hat 7.0:

Linux sarah.xxxxxxxxxxxxxxxxx 2.4.0-test11 #4 Sat Dec 9 14:24:20 CET
2000 i586 unknown
Kernel modules         2.3.21
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nls_iso8859-2 nls_cp852 vfat mad16 ad1848 sb_lib
                        uart401


DMESG:   http://kocour.ms.mff.cuni.cz/~macok/kernel/dmesg
(Abit PX5, P166 (ovrclckd to 166), 128MB RAM, 2x IDE HDD, 3com509b ISA, Opti931)

.config: http://kocour.ms.mff.cuni.cz/~macok/kernel/.config
(with IPv6 + tunneling, iptables (ipv4/ipv6), no devfsd).

Have a nice day

P.S. I'm not subscribed, please Cc: me eventually ...

-- 
   Martin Maèok
  underground.cz
    openbsd.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
