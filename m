Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCPABk>; Fri, 15 Mar 2002 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293538AbSCPABY>; Fri, 15 Mar 2002 19:01:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3490 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293540AbSCPAAq>;
	Fri, 15 Mar 2002 19:00:46 -0500
Date: Fri, 15 Mar 2002 15:57:48 -0800 (PST)
Message-Id: <20020315.155748.68123299.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16m1oW-00057N-00@the-village.bc.nu>
In-Reply-To: <20020315.154527.98068496.davem@redhat.com>
	<E16m1oW-00057N-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Sat, 16 Mar 2002 00:12:48 +0000 (GMT)
   
   I've actually got a more constructive suggestion for the zebra folks. 
   Route the BGP crap through a netlink tap device, mangle and unmangle the
   tcp frames in luserspace. Saves doing TCP in userspace, saves screwing up
   Dave's nice networking stack.
   
   You'll still need to kill SACK support to make it fit
   
Another solution could involve a netfilter module to mangle
the packets.

