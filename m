Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbREVVSh>; Tue, 22 May 2001 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbREVVS1>; Tue, 22 May 2001 17:18:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262827AbREVVSP>; Tue, 22 May 2001 17:18:15 -0400
Subject: Re: alpha iommu fixes
To: rth@twiddle.net (Richard Henderson)
Date: Tue, 22 May 2001 22:10:13 +0100 (BST)
Cc: jlundell@pobox.com (Jonathan Lundell), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        linux-kernel@vger.kernel.org, davem@redhat.com (David S. Miller)
In-Reply-To: <20010522140206.B4662@twiddle.net> from "Richard Henderson" at May 22, 2001 02:02:06 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152JPx-0002U8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 22, 2001 at 01:48:23PM -0700, Jonathan Lundell wrote:
> > 64KB for 8-bit DMA; 128KB for 16-bit DMA. [...]  This doesn't
> > apply to bus-master DMA, just the legacy (8237) stuff.
> 
> Would this 8237 be something on the ISA card, or something on
> the old pc mainboards?  I'm wondering if we can safely ignore
> this issue altogether here...

On the mainboards. Bus mastering ISA controllers have various limits of their
own but I dont believe the 64/128K one is required

