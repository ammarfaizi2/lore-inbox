Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268910AbRHBMaY>; Thu, 2 Aug 2001 08:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268913AbRHBMaO>; Thu, 2 Aug 2001 08:30:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37392 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268910AbRHBMaJ>; Thu, 2 Aug 2001 08:30:09 -0400
Subject: Re: booting SMP P6 kernel on P4 hangs.
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Thu, 2 Aug 2001 13:30:53 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1010801134415.19537C-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Aug 01, 2001 01:49:42 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SHcr-0000UF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 1 Aug 2001, Arjan van de Ven wrote:
> 
> > Oh it is. And it's due to a recommendation Intel makes to bios writers. 
> > As a result, every P4 I've encountered shares this bug. Intel knows it's
> > an invalid MP table, but refuses to change the recommendation.
> 
>  Where's the recommendation?  We might work it around somehow. 
> 
>  Alternatively we may just disable the SMP mode if the bootstrap CPU's
> real ID contradits the one in the MP table. 

I think just disable SMP in that case. There are currently no SMP Pentium IV
boxes and perhaps Intel will have fixed it by the time SMP Pentium IV exists
