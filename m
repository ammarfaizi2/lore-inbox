Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269030AbTCDRQD>; Tue, 4 Mar 2003 12:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269430AbTCDRQD>; Tue, 4 Mar 2003 12:16:03 -0500
Received: from cnq0-9.cablevision.qc.ca ([24.212.0.9]:42245 "EHLO
	cnqnt02.Cablevision.qc.ca") by vger.kernel.org with ESMTP
	id <S269030AbTCDRQC>; Tue, 4 Mar 2003 12:16:02 -0500
Message-ID: <3E64E1C8.9040309@securinet.qc.ca>
Date: Tue, 04 Mar 2003 12:26:32 -0500
From: =?ISO-8859-1?Q?David_Lagani=E8re?= <spanska@securinet.qc.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A suggestion for the netfilter part of the sources
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since a couple of new kernel versions already, I use to modify two files 
related to the netfilter part to be able to add more
ports for the IRC NAT module. I was wondering if you could definitively 
apply those modifications to the kernel sources.
Here are my two modifications:

In /usr/src/linux-2.4.20/net/ipv4/netfilter:
I change "#define MAX_PORTS 8" to "#define MAX_PORTS 15" in both 
"ip_conntrack_irc.c" and "ip_nat_irc.c".

I make those modifications to be able to add more ports than only 8 when 
loading the modules as there are actually
a lot more IRC ports than 8 (ex: 6660-6669, 7000, that's already 11).

I'd greatly appreciate a reply even though my suggestion is not a good one.

Thanks.

David Laganière
Network/System Administrator
Securinet Systems

