Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271370AbRHUDBS>; Mon, 20 Aug 2001 23:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271381AbRHUDBJ>; Mon, 20 Aug 2001 23:01:09 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:5654 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S271370AbRHUDAu>; Mon, 20 Aug 2001 23:00:50 -0400
Date: Tue, 21 Aug 2001 03:58:47 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: linux-kernel@vger.kernel.org
Subject: sync hanging
Message-ID: <Pine.LNX.4.21.0108210353520.11035-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I'm using kernel 2.4.8-ac2 on a Dual PIII-1000 with 4096M RAM, and a
reiserfs filesystem on a RAID-1 mirror of two 76GB UDMA disks, and I'm
experiencing a strange problem after the machine has been running for a
while.

Every now and again, running sync(1) (i.e. the program) seems to hang and
end up in state D (uninterruptible sleep). There is no way to kill it
(even with SIGKILL but I assume that this is typical for state D
processes.

Does anyone have any idea what may be causing this? I have searched the
archives and couldn't find anything similar.

Thanks,

Corin

PS: Please CC any replies to me.

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/


