Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUDKQj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUDKQj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:39:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:3201 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262422AbUDKQjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:39:55 -0400
X-Authenticated: #11437207
Date: Sun, 11 Apr 2004 18:08:31 +0200
From: Tim Blechmann <TimBlechmann@gmx.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ivica Ico Bukvic <ico@fuse.net>, daniel.ritz@gmx.ch,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
 -- First good news
Message-Id: <20040411180831.6e2432d3@laptop>
In-Reply-To: <20040411142527.A29837@flint.arm.linux.org.uk>
References: <200404100347.56786.daniel.ritz@gmx.ch>
	<20040410033032.XOVD8029.smtp1.fuse.net@64BitBadass>
	<20040411142527.A29837@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

> > The 06 to 04 may be the critical element as even when I have
> > everything properly running in Win32, when I alter this number the
> > distortion returns
> 
> $ setpci -s a.0 0xc9.b
> 
> will display the value of this register under Linux, and:
> 
> $ setpci -s a.0 0xc9.b=value
i tried to read these registers on my cardbus bridge but on my system
the registers are zero (00) ... 
i tried to set these registers to the values ico had on his machines,
but it seems that i'm not able to set them ... if i read the registers
after setting them, they are still zero ...
is it possible to find out what this register is actually representing?

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

