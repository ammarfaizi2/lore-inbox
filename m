Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274457AbRITMeM>; Thu, 20 Sep 2001 08:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274456AbRITMeC>; Thu, 20 Sep 2001 08:34:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274457AbRITMdu>; Thu, 20 Sep 2001 08:33:50 -0400
Subject: Re: [PATCH] for drivers/char/sysrq.c
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Thu, 20 Sep 2001 13:38:16 +0100 (BST)
Cc: torvalds@transmeta.com, crutcher+kernel@datastacks.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200109200345.f8K3jbr29597@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Sep 19, 2001 09:45:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k35s-0005C3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How did something this basic get submitted in the first place?!?
> Doesn't anyone bother compiling patches before sending to Linus?
> This is the second time today I've had to patch the kernel just to get
> the rotten thing to compile. I'm not happy that whoever put in those
> __builtin_expect()'s didn't bother testing with THE RECOMMENDED
> COMPILER!!! It's not the first time that sort of thing has happened.
> </whinge>

It got broken because the stable kernel API isnt. When I submitted it to
Linus I missed one specific random api of the week variance. Its been in
the -ac tree and vendor distros for a while, so it was tested.

Alan
