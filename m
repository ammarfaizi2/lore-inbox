Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261932AbSI1PR5>; Sat, 28 Sep 2002 11:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbSI1PR4>; Sat, 28 Sep 2002 11:17:56 -0400
Received: from mail.uklinux.net ([80.84.72.21]:10000 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S261932AbSI1PRz>;
	Sat, 28 Sep 2002 11:17:55 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 28 Sep 2002 16:02:05 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: jbradford@dial.pipex.com
cc: Joerg Pommnitz <pommnitz@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Framebuffer still "EXPERIMENTAL"?
In-Reply-To: <200209271106.g8RB6PDg000759@darkstar.example.net>
Message-ID: <Pine.LNX.4.21.0209281558290.3427-100000@ppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002 jbradford@dial.pipex.com wrote:

> > Hello Listees,
> > yesterday I compiled 2.5.38 for the first time and noticed that the
> > framebuffer option is still marked "EXPERIMENTAL". Well, I know for sure
> > that I used the VESA-FB 3 years ago to get X running on a strange laptop
> > graphic chip, so it is at least that long available (actually I think it
> > got introduced for the Sparc port somewhen in 1995??). 
> > 
> > I think it's about time to promote the framebuffer code to a full fledged
> > kernel feature. Comments?
> 
> I've noticed a bug with it, but haven't had time to investigate more fully, infact it might not be a kernel bug, but I suspect that it is.  I don't usually use the framebuffer, (I prefer the standard text mode).
> 
> On a standard Slackware 8.1 install, (kernel 2.4.18), on a machine with an ATI graphics card, and with the framebuffer enabled, if you type clear, then fill the screen with text so that it scrolls, (e.g. do a find /), the top four lines where the penguin used to be do not scroll, they just keep the text that is originally put there.  If you press shift-pageup, and then shift-pagedown, it fixes it.
> 
> If anybody has got the time to look in to this, I'll post more details.
> 
> John.

 Normal operation. Either switch to a different tty, or set a font.

There does seem to be a bug in your mailer, though (excessive line
length) :->

Ken
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
 Out of the darkness a voice spake unto me, saying "smile, things could be
worse". So I smiled, and lo, things became worse.



