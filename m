Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264416AbRGELJd>; Thu, 5 Jul 2001 07:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGELJX>; Thu, 5 Jul 2001 07:09:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44038 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264279AbRGELJJ>; Thu, 5 Jul 2001 07:09:09 -0400
Subject: Re: 2.4.[56] kernel + xfree 4.1.0
To: justin@soze.net (Justin Guyett)
Date: Thu, 5 Jul 2001 12:09:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107041930090.32139-100000@gw.soze.net> from "Justin Guyett" at Jul 04, 2001 07:51:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I70U-0002Lw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mistaken?  If X isn't going to restore previous graphics modes, it doesn't
> seem to matter what mode the console was in, framebuffer or not, it still
> needs to be fixed regardless.
> 
> I'm presuming then that this is something the regular console driver needs
> to deal with?

All XFree86 problems. The kernel intentionally does not want to know about all
the things XFree knows about video cards. Possibly the kernel needs an ioctl
so XFree can ask 'and what do you think the display is right now' but thats
all, and its something I've so far seen no request for

