Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTANQQ2>; Tue, 14 Jan 2003 11:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTANQQ2>; Tue, 14 Jan 2003 11:16:28 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:47365 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S264705AbTANQQ0>;
	Tue, 14 Jan 2003 11:16:26 -0500
Message-ID: <3E2439A6.2060808@walrond.org>
Date: Tue, 14 Jan 2003 16:24:06 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.bk no longer boots from NFS root after bk pull this morning
References: <3E23E087.9020302@walrond.org> <shsof6j21cw.fsf@charged.uio.no>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
 >
 > Could you apply the RPC fix that I just posted to l-k, and then this
 > fix on top of it?
 >

That fixes it - thanks :)

I have a strange new dmesg entry though (see last line)

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
Freeing unused kernel memory: 312k freed
e100: eth0 NIC Link is Up 100 Mbps Full duplex
NFS: server cheating in read reply: count 4096 > recvd 1000

