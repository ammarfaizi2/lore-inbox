Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262832AbREVVL5>; Tue, 22 May 2001 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbREVVLs>; Tue, 22 May 2001 17:11:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262831AbREVVLh>; Tue, 22 May 2001 17:11:37 -0400
Subject: Re: alpha iommu fixes
To: rth@twiddle.net (Richard Henderson)
Date: Tue, 22 May 2001 22:08:21 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        linux-kernel@vger.kernel.org, davem@redhat.com (David S. Miller)
In-Reply-To: <20010522132815.A4573@twiddle.net> from "Richard Henderson" at May 22, 2001 01:28:15 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152JOA-0002Ts-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 22, 2001 at 05:00:16PM +0200, Andrea Arcangeli wrote:
> > I'm also wondering if ISA needs the sg to start on a 64k boundary,
> Traditionally, ISA could not do DMA across a 64k boundary.

The ISA dmac on the x86 needs a 64K boundary (128K for 16bit) because it
did not carry the 16 bit address to the top latch byte. 

> 

