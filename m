Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264925AbUE2OSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUE2OSU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUE2OSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:18:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:35460 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264925AbUE2OSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:18:14 -0400
Date: Sat, 29 May 2004 16:18:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040529141833.GA14849@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <20040529140736.GD5175@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529140736.GD5175@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 04:07:36PM +0200, Andries Brouwer wrote:
> On Sat, May 29, 2004 at 09:09:53AM +0200, Vojtech Pavlik wrote:
> 
> > One more thought: The emulated PS/2 mouse so many people are complaining
> > about is there only because applications like X cannot use the native
> > event interface. It was intended to be removed after that support is
> > added, but with X development being as slow as it is, it didn't ever
> > happen.
> 
> A mistake.

Well, yes. It's just 99% compatible, and it wasn't removed yet. But I
still hope it eventually will.

> You add new functionality. That is good. At the same time you want
> to force people to use this new stuff by throwing out the old. Bad.
> 
> It is almost impossible to remove features from the kernel.

I had hoped with so few programs using it (basically only X), it
shouldn't be so impossible.

> People have a great variety of user space setups, and can have
> lots of reasons why it is undesirable or impossible to change
> their software, while a new kernel may be required to support
> new hardware or for security reasons.
> 
> One should always (i) go in a long series of tiny steps,
> (ii) attempt to be 100% backwards compatible.
> Obsoleting old stuff is done over a period of more than
> five years, if at all.
> 
> Andries
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
