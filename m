Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRFNU4t>; Thu, 14 Jun 2001 16:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbRFNU4k>; Thu, 14 Jun 2001 16:56:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53427 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261425AbRFNU4Y>;
	Thu, 14 Jun 2001 16:56:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.9461.551559.168878@pizda.ninka.net>
Date: Thu, 14 Jun 2001 13:56:21 -0700 (PDT)
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Tom Gall <tom_gall@vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <p05100301b74ed3224ec5@[10.128.7.49]>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
	<3B28C6C1.3477493F@mandrakesoft.com>
	<15144.51504.8399.395200@pizda.ninka.net>
	<p0510030eb74ea25caa73@[207.213.214.37]>
	<15145.2693.704919.651626@pizda.ninka.net>
	<p05100301b74ed3224ec5@[10.128.7.49]>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Lundell writes:
 > It's easier in architectures other than IA32, in a way, since they
 > typically don't have the 64KB IO-space addressing limitation that
 > makes heavily bridged systems problematical on IA32 (one tends to
 > run out of IO space).

Right, I was even going to mention this.

But nothing stops an ia32 PCI controller vendor from doing what the
Sun PCI controller does, which is to make I/O space memory mapped.
Well, one thing stops them, no OS would support this from the get
go.

Luckily, it would be quite easy to make Linux handle this kind of
thing on x86 since other platforms built up the infrastructure
needed to make it work.

Later,
David S. Miller
davem@redhat.com
