Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276048AbRI1XE1>; Fri, 28 Sep 2001 19:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276356AbRI1XES>; Fri, 28 Sep 2001 19:04:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276048AbRI1XED>; Fri, 28 Sep 2001 19:04:03 -0400
Subject: Re: CPU frequency shifting "problems"
To: andrew.grover@intel.com (Grover, Andrew)
Date: Sat, 29 Sep 2001 00:09:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), torvalds@transmeta.com,
        padraig@antefacto.com, linux-kernel@vger.kernel.org
In-Reply-To: <8FB7D6BCE8A2D511B88C00508B68C2081971E4@orsmsx102.jf.intel.com> from "Grover, Andrew" at Sep 28, 2001 04:01:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n6ki-0000Gp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We do 5uS per transition 4 transitions per bit, 64bits. So thats 1.2mS
> > or using the PM timer thats 0.25 seconds
> 
> OK ya lost me...;-)

I got my maths wrong by a slight factor of 1000, ignore me - there is a
reason I didnt do maths at university 8)

> Both Windows and FreeBSD-CURRENT use the PM timer for udelays. It is 3579545
> Hz. ~2.71 ticks per usec. Read the PM timer, add (2.71 * 5), loop on reading
> the PM timer until it reaches that, and (give or take) you have a 5us delay
> that does not depend on the TSC.

4MHz is not actually too bad at all, providing the reading overhead is 
low
