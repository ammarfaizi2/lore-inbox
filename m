Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSFLXiM>; Wed, 12 Jun 2002 19:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSFLXiM>; Wed, 12 Jun 2002 19:38:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29398 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314243AbSFLXiL>;
	Wed, 12 Jun 2002 19:38:11 -0400
Date: Wed, 12 Jun 2002 16:33:44 -0700 (PDT)
Message-Id: <20020612.163344.31410429.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, saw@saw.sw.com.sg,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: NAPI for eepro100
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D07D6A6.7090308@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 12 Jun 2002 19:17:58 -0400

   Oh crap, you're right...   eepro100 in general does funky stuff with the 
   way packets are handled, mainly due to the need to issue commands to the 
   NIC engine instead of the normal per-descriptor owner bit way of doing 
   things.

The question is, do the descriptor bits have to live right before
the RX packet data buffer or can other schemes be used?
