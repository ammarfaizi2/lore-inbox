Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317369AbSFLXKC>; Wed, 12 Jun 2002 19:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFLXKB>; Wed, 12 Jun 2002 19:10:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10454 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317369AbSFLXKA>;
	Wed, 12 Jun 2002 19:10:00 -0400
Date: Wed, 12 Jun 2002 16:05:32 -0700 (PDT)
Message-Id: <20020612.160532.134201977.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, saw@saw.sw.com.sg,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: NAPI for eepro100
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D07D270.5060902@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 12 Jun 2002 19:00:00 -0400
   
   for the 'mips' patch, it looks 
   like the arch maintainer(s) need to fix the PCI DMA support...

No, it's worse than that.

See how non-consistent memory is used by the eepro100 driver
for descriptor bits?  The skb->tail bits?

That is very problematic.
