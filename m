Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131257AbRADTxH>; Thu, 4 Jan 2001 14:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbRADTw5>; Thu, 4 Jan 2001 14:52:57 -0500
Received: from comunit.de ([195.21.213.33]:46168 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S131257AbRADTwu>;
	Thu, 4 Jan 2001 14:52:50 -0500
Date: Thu, 4 Jan 2001 20:52:49 +0100 (CET)
From: Sven Koch <haegar@cut.de>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <Pine.LNX.4.21.0101042118530.3999-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.30.0101042051110.22989-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Igmar Palsenberg wrote:

> kernel 2.2.18 hates my Maxtor drive :
>
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: Maxtor 96147H6, 32253MB w/2048kB Cache, CHS=65531/16/63, (U)DMA
>
> Actual (correct) parameters : CHS=119112/16/63
>
> Looks like some short int (2 bytes) overflowing. I'll try the ide patches.

This type of harddisk works for me with the ide patches. I had to
recompile fdisk as my old suse 6.4 version got the same 2byte-wraparound
problem.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
