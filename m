Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132868AbQLNUbA>; Thu, 14 Dec 2000 15:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132911AbQLNUal>; Thu, 14 Dec 2000 15:30:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59528 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132868AbQLNUa1>;
	Thu, 14 Dec 2000 15:30:27 -0500
Date: Thu, 14 Dec 2000 11:43:49 -0800
Message-Id: <200012141943.LAA08330@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ionut@cs.columbia.edu
CC: mhaque@haque.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012141146320.27848-100000@age.cs.columbia.edu>
	(message from Ion Badulescu on Thu, 14 Dec 2000 11:52:29 -0800 (PST))
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <Pine.LNX.4.30.0012141146320.27848-100000@age.cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 14 Dec 2000 11:52:29 -0800 (PST)
   From: Ion Badulescu <ionut@cs.columbia.edu>

   The oops looks something like this. It was caught on serial
   console, and decoded on test11, so it doesn't have translation for
   module symbols. It if helps, this box is running ip_conntrack and
   the oops occurred basically as soon as an NFS request came in.

If you turn off netfilter, ip_conntrack, etc. does the OOPS still
occur?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
