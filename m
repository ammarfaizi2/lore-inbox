Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129946AbQK1KXZ>; Tue, 28 Nov 2000 05:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130180AbQK1KXP>; Tue, 28 Nov 2000 05:23:15 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:10328 "EHLO
        portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
        id <S129946AbQK1KXF>; Tue, 28 Nov 2000 05:23:05 -0500
Date: Tue, 28 Nov 2000 10:52:46 +0100
Message-Id: <200011280952.eAS9qkb01700@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: test-10 tulip "eth0 timed out" (smp, heavy IDE use)
In-Reply-To: <20001128042134.A1041@twoey>
X-Newsgroups: lt.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.4.0-test11 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001128042134.A1041@twoey> you wrote:

> Using 2.4-test10 I got a series of timeout errors on my tulip network
> card (Linksys LNE version 4, 00:0d.0 Ethernet controller: Bridgecom,
> Inc: Unknown device 0985 (rev 11)). Networking then completely stopped
> working. Restarting the interface with ifconfig fixed the problem.

> I am using an SMP kernel, compiled with gcc 2.95.2 on an ABit BP6 (dual
> celeron 500s, 128mb, PIIX4 using DMA).

> [log extract]
> Nov 28 04:04:52 twoey kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Nov 28 04:04:52 twoey kernel: eth0: Transmit timed out, status fc664010,
> CSR12 00000000, resetting...

I have the same problem with SMSC EPIC/100 83c170 Ethernet controller:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout using MII device, Tx status 0003.
eth0: Restarting the EPIC chip, Rx 4568454/4568454 Tx 6262613/6262623.
eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.

kernel 2.4.0-test11

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
