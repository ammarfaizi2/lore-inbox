Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271698AbTG2MiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTG2MiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:38:15 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:46473
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S271698AbTG2MiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:38:11 -0400
Date: Tue, 29 Jul 2003 08:53:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
Message-ID: <20030729085359.A12652@animx.eu.org>
References: <89B099B2CBF@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <89B099B2CBF@vcnet.vc.cvut.cz>; from Petr Vandrovec on Tue, Jul 29, 2003 at 01:51:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have an old matrox millenium 1 card.  does the matrox fb support this
> > card?  All I got was a blank screen.  fbcon and matroxfb with support for
> > I/II cards compiled in.  When I had vga16 compiled in as well, I would get the
> > console if I switched to vt2 and back to vt1.
> 
> Yes, it supports Millennium1 too. Are you sure that you built fbcon
> support into the kernel? And that you have only one fbdev, matroxfb?

Yes.  This caused a permenant black screen.  fbset did not give me anything
usable.  Monitor did not go into powersave.

> >From your description it looks to me like that you are using vesafb
> together with matroxfb.

I did, but that caused it to give a blank screen until I changed VTs.
I removed both vesafb and vga16 and recompiled to achive the result I stated
above.

I'll try 2.6.0-test2 later on today.  I did not do a make clean between
compiles.  When I compile test2, it will be clean, I never patch dirty
trees.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
