Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTAOLwG>; Wed, 15 Jan 2003 06:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbTAOLwF>; Wed, 15 Jan 2003 06:52:05 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:25608 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S266257AbTAOLwE>;
	Wed, 15 Jan 2003 06:52:04 -0500
Message-ID: <3E254D34.9030100@walrond.org>
Date: Wed, 15 Jan 2003 11:59:48 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.bk no longer boots from NFS root after bk pull this morning
References: <3E23E087.9020302@walrond.org> <shsof6j21cw.fsf@charged.uio.no>	<3E2439A6.2060808@walrond.org> <shsd6mz5zca.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
>      > NFS: server cheating in read reply: count 4096 > recvd 1000
> 
> Did this start with the 2.5.58 client? What is the server running?
> 


*** 2.5.57 is fine;

Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.103
IP-Config: Complete:
       device=eth0, addr=10.0.0.103, mask=255.255.0.0, gw=10.0.0.1,
      host=hal3.office, domain=office, nis-domain=(none),
      bootserver=10.0.0.1, rootserver=10.0.0.1, 
rootpath=/eboot/slash/hal.office
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem).

*** 2.5.58 is fine (with your patches so it boots)

Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.103
IP-Config: Complete:
       device=eth0, addr=10.0.0.103, mask=255.255.0.0, gw=10.0.0.1,
      host=hal3.office, domain=office, nis-domain=(none),
      bootserver=10.0.0.1, rootserver=10.0.0.1, 
rootpath=/eboot/slash/hal.office
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem).

*** 2.5 BK (same as yesterday)

Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.103
IP-Config: Complete:
       device=eth0, addr=10.0.0.103, mask=255.255.0.0, gw=10.0.0.1,
      host=hal3.office, domain=office, nis-domain=(none),
      bootserver=10.0.0.1, rootserver=10.0.0.1, 
rootpath=/eboot/slash/hal.office
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem).

*** Hmmm. No strange message this time

Sorry this isn't more useful. Anything else I can do?

