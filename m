Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261159AbRERQy6>; Fri, 18 May 2001 12:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261163AbRERQys>; Fri, 18 May 2001 12:54:48 -0400
Received: from dirac.dina.kvl.dk ([130.225.40.191]:62481 "EHLO
	dirac.dina.kvl.dk") by vger.kernel.org with ESMTP
	id <S261159AbRERQyj>; Fri, 18 May 2001 12:54:39 -0400
Date: Fri, 18 May 2001 18:54:00 +0200 (CEST)
From: "Thomas S. Iversen" <thomassi@dina.kvl.dk>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: PIO mode support for 82371mx?
In-Reply-To: <Pine.LNX.4.10.10105181234220.23244-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0105181847360.3316-100000@dirac.dina.kvl.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "accelerator"?  it's just another ide controller.

I know, but as you wrote, the marketing department and so forth.

> or the piix driver doesn't recognize the pci vid/did for this 
> particular chip.  both are easy to fix.

I figured out it had to be something along those lines, but I'm not sure
(I'm not at kernel developer, not even close). For a start this particular
instance of the 82371 does NOT support Bus mastering. It seems that all
other variants do.

> you should seriously consider getting something else to use,
> though: PIO is the pits.  it's been obsolete on desktops for 
> at least 5 years.

It's not a desktop :) It's a laptop and as such I'm pretty much stuck with
the IDE capabilities built into it :|

Regards Thomas, Denmark

