Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSFMIsU>; Thu, 13 Jun 2002 04:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSFMIsT>; Thu, 13 Jun 2002 04:48:19 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:5907 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S317528AbSFMIsT>;
	Thu, 13 Jun 2002 04:48:19 -0400
Message-ID: <20020613125753.A23693@castle.nmd.msu.ru>
Date: Thu, 13 Jun 2002 12:57:53 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "David S. Miller" <davem@redhat.com>
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: NAPI for eepro100
In-Reply-To: <3D0740ED.2060907@ict.ac.cn> <3D07D270.5060902@mandrakesoft.com> <20020612.160532.134201977.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 04:05:32PM -0700, David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Wed, 12 Jun 2002 19:00:00 -0400
>    
>    for the 'mips' patch, it looks 
>    like the arch maintainer(s) need to fix the PCI DMA support...
> 
> No, it's worse than that.
> 
> See how non-consistent memory is used by the eepro100 driver
> for descriptor bits?  The skb->tail bits?
> 
> That is very problematic.

What's the problem?
If it isn't allowed to do, then what is the meaning of PCI_DMA_BIDIRECTIONAL
mappings?

	Andrey
