Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276112AbRJBSVK>; Tue, 2 Oct 2001 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276110AbRJBSVA>; Tue, 2 Oct 2001 14:21:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38665 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276099AbRJBSUp>; Tue, 2 Oct 2001 14:20:45 -0400
Subject: Re: Which is currently the most stable 2.4 kernel?
To: mason@suse.com (Chris Mason)
Date: Tue, 2 Oct 2001 19:25:59 +0100 (BST)
Cc: rankincj@yahoo.com (Chris Rankin), linux-kernel@vger.kernel.org
In-Reply-To: <306940000.1002046587@tiny> from "Chris Mason" at Oct 02, 2001 02:16:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oUEx-0005Ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does anyone have any kernel recommendations /
> > counter-recommendations, please? One server is SMP,
> > the other is UP, and both are Intel architecture.
> 
> PPP is not SMP safe in 2.4.x.  You'll run into problems on any kernel
> there.  Even on single processor systems, you need the ppp patch in
> 2.4.9-ac16 or 2.4.11pre1.
> 
> Other than that, 2.4.10 + andrea's vmtweaks patch does well.  2.4.9-ac18 is
> a good alternative.

I'd probably apply them to 2.4.7 based trees as they have more history so
you can meaningfully answer the reliability question in statistical terms.
The others are too new to be 100% sure.

Also for remote systems configure watchdog support. That'll get you out of
so many disasters, software, hardware or other that its a godsend
