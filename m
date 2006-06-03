Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWFCGdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWFCGdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 02:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWFCGdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 02:33:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932571AbWFCGdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 02:33:42 -0400
Date: Sat, 3 Jun 2006 08:32:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: David Lang <dlang@digitalinsight.com>, Ondrej Zajicek <santiago@mail.cz>,
       Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060603063251.GF6931@elf.ucw.cz>
References: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain> <20060602085832.GA25806@elf.ucw.cz> <Pine.LNX.4.63.0606021146320.4686@qynat.qvtvafvgr.pbz> <20060602220104.GA6931@elf.ucw.cz> <Pine.LNX.4.63.0606021256470.4686@qynat.qvtvafvgr.pbz> <4480C8D9.5080309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4480C8D9.5080309@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 03-06-06 07:25:13, Antonino A. Daplas wrote:
> David Lang wrote:
> > On Sat, 3 Jun 2006, Pavel Machek wrote:
> >> I'm not talking about reading speed, I'm talking about displaying
> >> speed. Once you display more than refresh rate times screen
> >> size... you may as well cheat -- xterm-like. If xterm detects too much
> >> stuff is being displayed, it simply stops displaying it, only
> >> refreshing screen few times a second...
> > 
> > That would work, however AFAIK it's not implemented in any existing
> > framebuffer.
> 
> Besides implementaton, the main concern with this is that you might miss
> a very important kernel message.  Though one can always use the scrollback
> buffer.

Well, you can only miss a message *you would not see anyway*. I guess
the main concern is that it tends to look ugly on the screen (and it
will not be quite easy code).

Anyway, no, I do not think it is needed. framebuffers are fast enough
these days. When I used to have 300MHz toshiba laptop with UHCI
bogging down the system, something like that would be handy... (2sec
to do screen update in loaded-with-usb cases).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
