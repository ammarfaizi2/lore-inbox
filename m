Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTANJ4R>; Tue, 14 Jan 2003 04:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTANJ4R>; Tue, 14 Jan 2003 04:56:17 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:49162 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S261996AbTANJ4Q>;
	Tue, 14 Jan 2003 04:56:16 -0500
Message-ID: <3E23E087.9020302@walrond.org>
Date: Tue, 14 Jan 2003 10:03:51 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.bk no longer boots from NFS root after bk pull this morning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 has been booting fine over NFS for ages, but after getting latest 
stuff with a bk pull this morning, it no longer works

Do I need to do something new, or has something busted?

The relevant bits from dmesg are

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
net/sunrpc/rpc_pipe.c: rpc_lookup_path failed to find path 
/mount/clntc398a880
RPC: Couldn't create pipefs entry /mount/clntc398a880
Root-NFS: Server returned error -13 while mounting /eboot/slash/hal.office
VFS: Unable to mount root fs via NFS, trying floppy.
Kernel panic: VFS: Unable to mount root fs on 02:00


Andrew Walrond

