Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbRAWTDM>; Tue, 23 Jan 2001 14:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbRAWSzM>; Tue, 23 Jan 2001 13:55:12 -0500
Received: from adglinux1.hns.com ([139.85.108.152]:61853 "EHLO
	adglinux1.hns.com") by vger.kernel.org with ESMTP
	id <S131226AbRAWSzC>; Tue, 23 Jan 2001 13:55:02 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 statd trouble
From: nbecker@fred.net
Date: 23 Jan 2001 13:55:48 -0500
Message-ID: <x888zo29jyj.fsf@adglinux1.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.0

I have quite a lot of these log messages:

Jan 23 18:28:52 adglinux1 rpc.statd[1532]: gethostbyname error for adglinux1.hns.com
Jan 23 18:28:52 adglinux1 rpc.statd[1532]: STAT_FAIL to adglinux1.hns.com for SM_MON of 139.85.108.141
Jan 23 13:28:52 adglinux1 kernel: lockd: cannot monitor 139.85.108.141

I am running a local named, and resolv.conf has:

search md.hns.com hns.com
nameserver 127.0.0.1
nameserver 139.85.92.109
nameserver 139.85.52.100

So I can't imagine why gethostbyname have any problem either for
adglinux1.hns.com or for 139.85.108.141.

Here's what nslookup says on the same machine:

nslookup 139.85.108.141
Server:  localhost.0.0.127.in-addr.arpa
Address:  127.0.0.1
 
Name:    rpppc2.hns.com
Address:  139.85.108.141

Any ideas?
                                              
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
