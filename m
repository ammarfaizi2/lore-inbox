Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSCRCKF>; Sun, 17 Mar 2002 21:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312170AbSCRCJz>; Sun, 17 Mar 2002 21:09:55 -0500
Received: from quechua.inka.de ([212.227.14.2]:33150 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S312169AbSCRCJn>;
	Sun, 17 Mar 2002 21:09:43 -0500
From: Bernd Eckenfels <ecki-news2002-03@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Trapping all Incoming Network Packets
In-Reply-To: <Pine.GSO.4.33.0203171840250.5841-100000@compserv3>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16mmai-0005Zr-00@sites.inka.de>
Date: Mon, 18 Mar 2002 03:09:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.33.0203171840250.5841-100000@compserv3> you wrote:
> I am trying to write a module that will redirect all the packets to my
> recv routine, instead of going to the recv routines of the specific
> protocols. For example, a packet with the protocol field ETH_P_IP should
> come to "my_recv" before going to ip_rcv.

You should elaborate for what you need it. You can use the TUN/TAP driver
for usermode, use netfilter hooks for filtering.

Greetings
Bernd
