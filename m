Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbRG2Wgm>; Sun, 29 Jul 2001 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268202AbRG2Wgc>; Sun, 29 Jul 2001 18:36:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45323 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266736AbRG2WgY>; Sun, 29 Jul 2001 18:36:24 -0400
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
To: mjustice@austin.rr.com
Date: Sun, 29 Jul 2001 23:37:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072916503504.04012@bozo> from "Marvin Justice" at Jul 29, 2001 04:50:35 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QzC5-0002iN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On an unrelated topic the Serverworks LE chipset does not seem to be capable 
> of handling 4GB of RAM, despite what the board vendors claim in their specs. 
> When a 4th 1G stick is added the system gets really slow --- like maybe 
> cacheing is disabled. We've seen this on both Tyan and SuperMicro boards. The 
> HE chipset seems to be ok.

Check the mtrr setups. I've seen slow machines that are slow with 4Gb purely
because the bios misconfigured the memory type ranges

Alan
