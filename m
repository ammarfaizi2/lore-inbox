Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132325AbQL1DHj>; Wed, 27 Dec 2000 22:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbQL1DH3>; Wed, 27 Dec 2000 22:07:29 -0500
Received: from m845-mp1-cvx1a.col.ntl.com ([213.104.71.77]:41485 "EHLO
	[213.104.71.77]") by vger.kernel.org with ESMTP id <S132323AbQL1DHV>;
	Wed, 27 Dec 2000 22:07:21 -0500
To: "Jogchem de Groot" <c.dgroot@chello.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Kernel panics on sending large ping packets using 'ping'
In-Reply-To: <00122713500100.00417@kryptology>
From: "John Fremlin" <vii@penguinpowered.com>
Date: 28 Dec 2000 00:13:13 +0000
In-Reply-To: Jogchem de Groot's message of "Wed, 27 Dec 2000 14:13:29 +0100"
Message-ID: <m2k88lmmhy.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Jogchem de Groot <c.dgroot@chello.nl> writes:

[...]

> 1: Kernel panics on sending large ping packets using 'ping'

Not for me.

[...]

> 4: Linux version 2.4.0-test12

Linux 2.4.0-test13-pre4-tosatti

[...]

> 6: #!/bin/sh
>     ping -s 60000 127.0.0.1

Ping from netkit-combo-0.17:

# ping -s 60000 127.0.0.1
PING 127.0.0.1 (127.0.0.1): 60000 octets data
60008 octets from 127.0.0.1: icmp_seq=0 ttl=255 time=5.6 ms
60008 octets from 127.0.0.1: icmp_seq=1 ttl=255 time=4.8 ms
60008 octets from 127.0.0.1: icmp_seq=2 ttl=255 time=4.8 ms

[...]

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
