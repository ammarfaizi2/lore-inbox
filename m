Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVA0QX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVA0QX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVA0QX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:23:57 -0500
Received: from mail.suse.de ([195.135.220.2]:27027 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262654AbVA0QXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:23:50 -0500
Date: Thu, 27 Jan 2005 17:24:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Andries Brouwer <aebr@win.tue.nl>,
       dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 access timings
Message-ID: <20050127162403.GA15205@ucw.cz>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106838875.14782.20.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:14:36PM +0000, Alan Cox wrote:

> On Maw, 2005-01-25 at 20:37, Lee Revell wrote:
> > Seems like a comment along the lines of "foo hardware doesn't work right
> > unless we delay a bit here" is the obvious solution.  Then someone can
> > easily disprove it later.
> 
> Myths are not really involved here. The IBM PC hardware specifications
> are fairly well defined and the various bits of "we glued a 2Mhz part
> onto the bus" stuff is all well documented. Nowdays its more complex
> because most kbc's aren't standalone low end microcontrollers but are
> chipset integrated cells or even software SMM emulations.
> 
> The real test is to fish out something like an old Digital Hi-note
> laptop or an early 486 board with seperate kbc and try it.

I'm testing it on an NexGen Nx586 VL-BUS board that has a separate i8042
controller. ;) Remember NexGen?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
