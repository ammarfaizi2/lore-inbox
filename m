Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSIFETf>; Fri, 6 Sep 2002 00:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSIFETf>; Fri, 6 Sep 2002 00:19:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24706 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318287AbSIFETe>;
	Fri, 6 Sep 2002 00:19:34 -0400
Date: Thu, 05 Sep 2002 21:17:03 -0700 (PDT)
Message-Id: <20020905.211703.38779558.davem@redhat.com>
To: niv@us.ibm.com
Cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1031286047.3d782d1f27162@imap.linux.ibm.com>
References: <1031283490.3d7823228d9ed@imap.linux.ibm.com>
	<20020905.205842.127265672.davem@redhat.com>
	<1031286047.3d782d1f27162@imap.linux.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Thu,  5 Sep 2002 21:20:47 -0700
   
   Sure :). The motivation for seeing the stats though would
   be to get an idea of how much retransmission/SACK etc 
   activity _is_ occurring during Troy's SpecWeb runs, which
   would give us an idea of how often we're actually doing
   segmentation offload, and better idea of how much gain
   its possible to further get from this(ahem) DMA coalescing :).
   Some of Troy's early runs had a very large number of
   packets dropped by the card.

One thing to do is make absolutely sure that flow control is
enabled and supported by all devices on the link from the
client to the test spedweb server.

Troy can do you do that for us along with the statistic
dumps?

Thanks.
