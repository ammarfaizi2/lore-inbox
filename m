Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274613AbRIYWb1>; Tue, 25 Sep 2001 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRIYWbR>; Tue, 25 Sep 2001 18:31:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60564 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274613AbRIYWbB>;
	Tue, 25 Sep 2001 18:31:01 -0400
Date: Tue, 25 Sep 2001 15:31:19 -0700 (PDT)
Message-Id: <20010925.153119.91756467.davem@redhat.com>
To: acmay@acmay.homeip.net
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] ipip.c & ip_gre.c (Add Tunnel return)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010925152628.A8042@ecam.san.rr.com>
In-Reply-To: <20010925152628.A8042@ecam.san.rr.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: andrew may <acmay@acmay.homeip.net>
   Date: Tue, 25 Sep 2001 15:26:28 -0700

   I think the tunnel drivers should return the name of the
   device the tunnel add created. Currently the tunnel_lookup
   functions copy the name into the stack var in the ioctl
   function but the ioctl copies the parm from the tunnel
   device.
   
Hmmm, net/ipv6/sit.c already has the version you propose. :-)))
Which one is correct?

Alexey, what do you think?

Franks a lot,
David S. Miller
davem@redhat.com
