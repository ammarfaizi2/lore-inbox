Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbREEW2h>; Sat, 5 May 2001 18:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbREEW21>; Sat, 5 May 2001 18:28:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135535AbREEW2S>;
	Sat, 5 May 2001 18:28:18 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15092.32371.139915.110859@pizda.ninka.net>
Date: Sat, 5 May 2001 15:28:03 -0700 (PDT)
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <3AF4720F.35574FDD@candelatech.com>
In-Reply-To: <3AF4720F.35574FDD@candelatech.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear writes:
 > This patch is ported from Andi Kleen's work for the 2.2.19 kernel (I think
 > it was his, at least...)
 > 
 > It adds the ability to run multiple interfaces on the same subnet,
 > on the same machine, and have the ARPs for each interface be answered
 > based on whether or not the kernel would route a packet from the ARP'd
 > IP out that interface.  When used with source-based routing, this
 > makes things work in an intuitive manner.

How difficult is it to compose netfilter rules that do this?

Later,
David S. Miller
davem@redhat.com
