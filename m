Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266151AbRGGNDd>; Sat, 7 Jul 2001 09:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266152AbRGGNDX>; Sat, 7 Jul 2001 09:03:23 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49863 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266151AbRGGNDK>;
	Sat, 7 Jul 2001 09:03:10 -0400
Message-ID: <3B47087E.80C514F@mandrakesoft.com>
Date: Sat, 07 Jul 2001 09:02:54 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Weichselbraun <albert+kernel@iaeste.or.at>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: rtl8139 dhcp-autoconfiguration problem
In-Reply-To: <20010707142145.A6988@iaeste.or.at> <3B470009.2BA7C123@mandrakesoft.com> <20010707150514.A7370@iaeste.or.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Weichselbraun wrote:
> 
> On 2001-07-07 at 08:26:49 -0400, Jeff Garzik wrote:
> > Can you try 2.4.6 please?
> done.
> - sorry, but 2.4.6 doesn't work either.
> 
> <dmesg kernel="2.4.6" net="8139too">
> ...
> 8139too Fast Ethernet driver 0.9.18-pre4
> PCI: Found IRQ 10 for device 00:09.0
> eth0: RealTek RTL8139 Fast Ethernet at 0xe0800000, 00:00:21:fa:20:ce, IRQ 10
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 4096 buckets, 32 Kbytes
> TCP: Hash table configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Root-NFS: No NFS server available, giving up.
> ...
> </dmesg>

did you boot with ip=bootp or ip=dhcp or ip=rarp?

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
