Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbRE2Evd>; Tue, 29 May 2001 00:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbRE2EvX>; Tue, 29 May 2001 00:51:23 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:55569 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S263203AbRE2EvP>; Tue, 29 May 2001 00:51:15 -0400
Date: Tue, 29 May 2001 00:50:59 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: James Simmons <jsimmons@transvirtual.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AT keyboard optional on i386?
In-Reply-To: <Pine.LNX.4.10.10105282027030.3783-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.33.0105290021420.12495-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James!

> So as you can see even USB keyboards depend on pc_keyb.c. So their is
> no way around this.

Perhaps redefining kbd_read_input() will help. It's cruel, I know :-)

> You can a few nice tricks with it like plug in two PS/2 keyboards. I
> have this for my home setup. The only thing is make sure you don't
> have both keyboards plugged in when you turn your PC on. I found BIOS
> get confused by two PS/2 keyboards. As you can it is very easy to
> multiplex many keyboards with the above design. I have had 4 different
> keyboards hooked up to my system and functioning at the same time. We
> even got a Sun keyboard to work on a intel box :-)

That's what we like Linux for. It doesn't get confused when everything
else does :-)

Thanks for your very interesting reply.

-- 
Regards,
Pavel Roskin

