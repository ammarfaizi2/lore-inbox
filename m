Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289323AbSAOAkU>; Mon, 14 Jan 2002 19:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289325AbSAOAkL>; Mon, 14 Jan 2002 19:40:11 -0500
Received: from www.transvirtual.com ([206.14.214.140]:38417 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S289323AbSAOAjz>; Mon, 14 Jan 2002 19:39:55 -0500
Date: Mon, 14 Jan 2002 16:39:43 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev currcon
Message-ID: <Pine.LNX.4.10.10201141618410.1714-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch only applies for the -dj tree since the new fbdev api is going
in there for now. This patch makes every fbdev driver uses the currcon
that I have placed in struct fb_info. Currently most drivers have currcon,
not the one for the console system, global. This is a problem if you have
more than one card. I have tested to see if this compiles on ix86 but
this patch is extensive so I like people to apply this patch to test it
out against the dj14 tree. The patch is to big to post so it is avalibale
at the following link:

NOTE: The setcolreg patch has to be applied first.

http://www.transvirtual.com/~jsimmons/setcolreg.diff
http://www.transvirtual.com/~jsimmons/fbcurrcon.diff

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/



