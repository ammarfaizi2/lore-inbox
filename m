Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSG1Shn>; Sun, 28 Jul 2002 14:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSG1Shn>; Sun, 28 Jul 2002 14:37:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50108 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317012AbSG1Shm>;
	Sun, 28 Jul 2002 14:37:42 -0400
Date: Sun, 28 Jul 2002 20:40:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020728204051.A15238@ucw.cz>
References: <20020720222905.GA15288@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020720222905.GA15288@outpost.ds9a.nl>; from ahu@ds9a.nl on Sun, Jul 21, 2002 at 12:29:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 12:29:05AM +0200, bert hubert wrote:
> Vojtech, list,
> 
> I find that my keyboard only works if I turn on the local APIC on UP on my
> laptop. The only clue I see scrolling past is something about 'AT keyboard
> timeout, not present?'. I don't have my nullmodem cable handy to check it
> out further.
> 
> I do see it talking about interrupt 1 and IO 0x60. I've also compiled it
> with the SERIO debugging setting and ATKBD debugging on, but I still don't
> see anything useful.
> 
> Every once in a while it would say 'unknown scancode from keybord set 0,
> 0x2' and then some more numbers. I feel bad that I can't be anymore specific
> right now.
> 
> If you want me to do some more checking, let me know, and I'll hook up the
> serial.

Can you check with 2.5.29? Several bugs in the keyboard support were
fixed.

-- 
Vojtech Pavlik
SuSE Labs
