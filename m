Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQJ3Mrf>; Mon, 30 Oct 2000 07:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129372AbQJ3MrQ>; Mon, 30 Oct 2000 07:47:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32320 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129215AbQJ3MrD>; Mon, 30 Oct 2000 07:47:03 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Mon, 30 Oct 2000 12:47:10 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), linux-kernel@vger.kernel.org
In-Reply-To: <20001030010434.A19615@vger.timpanogas.org> from "Jeff V. Merkey" at Oct 30, 2000 01:04:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qELI-0006q0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We will never beat NetWare on scaling if this is the case, even in 2.4.  
> Andre and my first job will be to create an arch port with MANOS that
> disables this and restructures the VM.  

In the 2.4 case if you are just running NFS daemons then there are no tlb
reloads going on at all. Whats murdering you is mostly memory copies. I would
suspect if you rerun the profiles on a box with a much lower memory bandwidth
that the effect will be even more visible
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
