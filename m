Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUFRPgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUFRPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUFRPfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:35:40 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:14847 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S265212AbUFRPes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:34:48 -0400
Subject: Re: [BUG] 2.6.x ALSA sound is pretty broken
From: Hetfield <hetfield666@virgilio.it>
Reply-To: hetfield666@virgilio.it
To: linux-kernel@vger.kernel.org
In-Reply-To: <s5hn031ndbl.wl@alsa2.suse.de>
References: <1087567432.9282.17.camel@blight.blight>
	 <1087567977.9285.21.camel@blight.blight>  <s5hn031ndbl.wl@alsa2.suse.de>
Content-Type: text/plain
Organization: Hetfield
Message-Id: <1087572882.1936.7.camel@blight.blight>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 17:34:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il ven, 2004-06-18 alle 16:35, Takashi Iwai ha scritto:
> At Fri, 18 Jun 2004 16:12:58 +0200,
> Hetfield wrote:
> > 
> > example: "beep"  when i execute beep i hear no sounds, neither from
> > speakers (audio card) 
> > nor from internal pc speaker.
> 
> Did you enable CONFIG_INPUT_PCSPKR?

sorry i can't find it! i searched whole sound system part of menuconfig
without finding nothing similar...

> 
> > in kde environment kconsole doesn't beep too.
> > mplayer seems to have some problem using the alsa output, giving strange messages.
> > (using oss emulation works good, with the only bad sound quality problem)
> 
> Then it's a mlayer specific problem.
> 

i suppose so too. i'll fill an mplayer bug.
however it seems that the problem is with IDE driver, when DMA is
enabled. Can the right team investigate for that?

thanks
> 
> Takashi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

________________________________________________________________________
Hetfield
www.blight.tk

