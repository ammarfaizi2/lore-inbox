Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbRECWUg>; Thu, 3 May 2001 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbRECWU1>; Thu, 3 May 2001 18:20:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55305 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135266AbRECWUN>; Thu, 3 May 2001 18:20:13 -0400
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
To: brownfld@irridia.com (Ken Brownfield)
Date: Thu, 3 May 2001 23:23:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        macro@ds2.pg.gda.pl (Maciej W. Rozycki), linux-kernel@vger.kernel.org,
        hugh@veritas.com (Hugh Dickins)
In-Reply-To: <200105032207.RAA11260@asooo.flowerfire.com> from "Ken Brownfield" at May 03, 2001 03:07:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vRVN-0006Ke-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the distributions use _the_ kernel.  Even if -ac is fixed, it's not 
> really something I would be willing to put in production.  Until I found 

Actually by unit count Linus is currently losing to me on 2.4 shipping.
Thats one reason I really want to get the stuff I have back into the main
tree.

> the noapic work-around, we were basically going to have to move off of 
> Linux.  I could very well be an isolated case, but the APIC issues I'm 
> seeing scare me, and not just for my sake.

Can you give me the detailed boot up messages from one of your HP boxes and
some more info. Also can you run dmidecode.c from
	ftp://ftp.linux.org.uk/pub/linux/alan

on them and send me the DMI strings. You will need to run it as root but
it can be run on a live system (at least I dont know of any bugs in it and
it only reads from raw BIOS memory not writes).

Alan

