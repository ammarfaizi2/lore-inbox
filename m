Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313790AbSDPRvq>; Tue, 16 Apr 2002 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313795AbSDPRvp>; Tue, 16 Apr 2002 13:51:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313790AbSDPRvn>; Tue, 16 Apr 2002 13:51:43 -0400
Subject: Re: [PATCH] fix ips driver compile problems
To: haveblue@us.ibm.com (Dave Hansen)
Date: Tue, 16 Apr 2002 19:09:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3CBC4D18.1090005@us.ibm.com> from "Dave Hansen" at Apr 16, 2002 09:11:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xXOQ-0000VQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know that none of the real authors is actively working on fixing this. 
>   Can this be accepted as a band-aid until the maintainers decide to 
> maintain a 2.5 driver, or are we pushing authors to rewrite drivers 
> which don't use the new DMA scheme?

Its not a band aid, its a bug. It happens to work by freak chance on x86.
Its much better it stays visibly broken until its fixed. You never
know, Jack may find someone else fixed it for him along the way.
