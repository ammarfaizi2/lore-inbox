Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317886AbSFNETR>; Fri, 14 Jun 2002 00:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSFNETQ>; Fri, 14 Jun 2002 00:19:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27876 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317886AbSFNETO>;
	Fri, 14 Jun 2002 00:19:14 -0400
Date: Thu, 13 Jun 2002 21:14:25 -0700 (PDT)
Message-Id: <20020613.211425.60193542.davem@redhat.com>
To: oliver@neukum.name
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206111623.30842.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Tue, 11 Jun 2002 16:23:30 +0200
   
   Still does that justify the overhead and the complications ?
   Couldn't we provide for the worst case in a generic kernel
   and make it a compile time option ?

I already posted that using the worst case scenerio would be an
acceptable solution to this problem, I consider it a closed issue
and you can ignore my earlier gripes on this issue.
