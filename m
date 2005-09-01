Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVIANX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVIANX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVIANXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:23:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:2761 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S965100AbVIANXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:23:55 -0400
Date: Thu, 1 Sep 2005 15:24:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Zoltan Szecsei <zoltans@geograph.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20050901132409.GA29134@midnight.suse.cz>
References: <4316E5D9.8050107@geograph.co.za> <20050901122253.GA11787@midnight.suse.cz> <4316FD08.1070505@geograph.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4316FD08.1070505@geograph.co.za>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:07:20PM +0200, Zoltan Szecsei wrote:

> >>(When) Will there ever be native kernel (and maybe XFree) support for 
> >>multiple independent keyboards?
> >
> >The kernel console is unlikely to ever going to have that - noone is
> >interested in changing the console subsystem.
> > 
> >
> Ah, rats! :-(

You can give a try, if you're not afraid opening that can of worms.

> >The current state of input device support in the kernel, however, allows
> >any userspace program to access them independently, including keyboards.
> >
> >That means multi-user X and possibly a userspace console implementation
> >(Jon Smirl is planning one) has no barriers in the kernel input device

> Do you have an email address so that I can keep in touch with him?

jonsmirl@gmail.com

> >implementation keeping it from proceeding.
> >
> >The problems with multiple VGA cards, etc, are much harder to solve,
> >though.

> That's a surprise - barring the keyboard issue, I thought I was close to 
> getting it working on my SuSE 9.3 using 2 mice, onboard 915G graphics 
> and an old TSENG Labs ET6000.
> Maybe I had further to go than I realised :-(

Some combinations work. Making it work for all is what's hard.

Btw, Aivils Stoss created a nice way to make several X instances have
separate keyboards - see the linux-console archives for the faketty
driver.

> >Many people would like that. But not many enough to make it happen, at
> >least not until now.

> Ah cool - there's hope - any pointers on how I can get a counter or 
> lobby group going?  :-)

Just start coding. ;) That helps most. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
