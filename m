Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSFLW5y>; Wed, 12 Jun 2002 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSFLW4O>; Wed, 12 Jun 2002 18:56:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61653 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317366AbSFLWzw>;
	Wed, 12 Jun 2002 18:55:52 -0400
Date: Wed, 12 Jun 2002 15:51:23 -0700 (PDT)
Message-Id: <20020612.155123.116838674.davem@redhat.com>
To: oliver@neukum.name
Cc: david-b@pacbell.net, roland@topspin.com, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206122158.55375.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Wed, 12 Jun 2002 21:58:55 +0200

   Perhaps I might point out that we need a solution for 2.4.

For 2.4.x just do the DMA alignment macro idea.  That would
be the easiest change to verify.
