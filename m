Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRHSOJJ>; Sun, 19 Aug 2001 10:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270472AbRHSOI7>; Sun, 19 Aug 2001 10:08:59 -0400
Received: from www.transvirtual.com ([206.14.214.140]:54542 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S270464AbRHSOIm>; Sun, 19 Aug 2001 10:08:42 -0400
Date: Sun, 19 Aug 2001 07:08:29 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, mj@ucw.cz,
        linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Patch, please TEST: linux-2.4.9 console font
 modularization
In-Reply-To: <Pine.LNX.4.05.10108191147400.16179-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10108190706490.1190-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What's wrong with the ancient console ioctl()s to change the font at runtine?
> (damned, I can't remember the name of the command)

Their is a bunch of them but the one mosted used is KD_FONT_OP_*. Look at
linux/kd.h for more details. The nice bonus about this is that it is
driver independent.  

