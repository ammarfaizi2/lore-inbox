Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277440AbRJEOry>; Fri, 5 Oct 2001 10:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277400AbRJEOrn>; Fri, 5 Oct 2001 10:47:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277398AbRJEOr3>; Fri, 5 Oct 2001 10:47:29 -0400
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
To: landley@trommello.org
Date: Fri, 5 Oct 2001 15:51:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org
In-Reply-To: <01100419590005.02393@localhost.localdomain> from "Rob Landley" at Oct 04, 2001 07:59:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pWKG-0006aj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So would a workable (if naieve) attempt to use Andrea's 
> memory-zones-grouped-into-classes approach on NUMA just involve making a 
> class/zone list for each node?  (Okay, you've got to identify nodes, and 
> group together processors, bridges, DMAable devices, etc, but it seems like 
> that has to be done anyway, class/zone or not.)  How does what people want to 
> do for NUMA improve on that?

I fear it becomes an N! problem.

I'd like to hear what Andrea has planned since without docs its hard to 
speculate on how the 2.4.10 vm works anyway
