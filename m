Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBSPBZ>; Mon, 19 Feb 2001 10:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129238AbRBSPBQ>; Mon, 19 Feb 2001 10:01:16 -0500
Received: from [209.58.33.70] ([209.58.33.70]:50951 "EHLO ns1.sdnpk.org")
	by vger.kernel.org with ESMTP id <S129075AbRBSPBA>;
	Mon, 19 Feb 2001 10:01:00 -0500
Message-ID: <3A913520.3011C7D6@khi.sdnpk.org>
Date: Mon, 19 Feb 2001 20:00:48 +0500
From: Ansari <mike@khi.sdnpk.org>
X-Mailer: Mozilla 4.61 [en] (Win95; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Running Bind 9 on Redhat 7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !!

I am configuring Bind 9 on Redhat 7 but unable to start the named.
Here is my /var/log message log:


Feb 20 09:49:58 ns2 named[2003]: starting BIND 9.0.0
Feb 20 09:49:58 ns2 named[2005]: loading configuration from
'/var/named/named.bo
ot'
Feb 20 09:49:58 ns2 named[2005]: the default for the 'auth-nxdomain'
option is n
ow 'no'
Feb 20 09:49:58 ns2 modprobe: modprobe: Can't locate module net-pf-10
Feb 20 09:49:58 ns2 named[2005]: no IPv6 interfaces found
Feb 20 09:49:58 ns2 named[2005]: listening on IPv4 interface lo,
127.0.0.1#53
Feb 20 09:49:58 ns2 named[2005]: socket.c:1183: unexpected error:
Feb 20 09:49:58 ns2 named[2005]: setsockopt(10, SO_TIMESTAMP) failed
Feb 20 09:49:58 ns2 named[2005]: listening on IPv4 interface eth0,
209.58.33.71#
53
Feb 20 09:49:58 ns2 named[2005]: socket.c:1183: unexpected error:
Feb 20 09:49:58 ns2 named[2005]: setsockopt(12, SO_TIMESTAMP) failed
Feb 20 09:49:58 ns2 named[2005]: socket.c:1183: unexpected error:
Feb 20 09:49:58 ns2 named[2005]: setsockopt(9, SO_TIMESTAMP) failed
Feb 20 09:49:58 ns2 named[2005]: dns_master_load: db.127.0.0:1: no TTL
specified
Feb 20 09:49:58 ns2 named[2005]: dns_zone_load: zone
0.0.127.IN-ADDR.ARPA/IN: da
tabase db.127.0.0: dns_db_load failed: no ttl
Feb 20 09:49:58 ns2 named[2005]: loading zones: no ttl
Feb 20 09:49:58 ns2 named[2005]: exiting (due to fatal error)
Feb 20 09:50:00 ns2 CROND[2010]: (root) CMD (   /sbin/rmmod -as)


Anyone have an idea how to solve this problem.

Thanx,
Nauman Ansrai

