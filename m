Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136113AbRDVN2k>; Sun, 22 Apr 2001 09:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136114AbRDVN2a>; Sun, 22 Apr 2001 09:28:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136113AbRDVN2Y>; Sun, 22 Apr 2001 09:28:24 -0400
Subject: Re: Linux 2.4.3-ac12
To: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 22 Apr 2001 14:29:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), philb@gnu.org (Philip Blundell),
        junio@siamese.dhis.twinsun.com, manuel@mclure.org (Manuel McLure),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010422142224.D20807@flint.arm.linux.org.uk> from "Russell King" at Apr 22, 2001 02:22:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJw2-0005r5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Apr 22, 2001 at 02:10:41PM +0100, Alan Cox wrote:
> > 	Recommended
> > 	-----------
> > 	egcs-1.1.2		(miscompiles strstr  <2.4.4pre)
> > 	gcc 2.95.*		(miscompiles strstr  <2.4.4pre)
> 
> Aren't both of these "miscompilation" problems are referring to the file
> arch/i386/lib/strstr.c?  Therefore, its an x86 problem.  To use a phrase
> that Linus uses, "its not an interesting problem" for the other
> architectures.

In theory the strstr miscompile might bite any other architecture with a 
braindead set of string instructions, a ludicrously low register count and
inlined strsr. So yes its x86 only

The recommended compilers for non x86 are different too - eg you need
2.96 gcc for IA64, you need 2.95 not egcs for mips and so on.

