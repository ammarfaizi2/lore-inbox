Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290320AbSAPBHa>; Tue, 15 Jan 2002 20:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290316AbSAPBHR>; Tue, 15 Jan 2002 20:07:17 -0500
Received: from www.transvirtual.com ([206.14.214.140]:10763 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290314AbSAPBHO>; Tue, 15 Jan 2002 20:07:14 -0500
Date: Tue, 15 Jan 2002 17:07:00 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev fbgen cleanup
Message-ID: <Pine.LNX.4.10.10201151702130.31251-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!

    On to the massive fbdev cleanup. The second patch requires the first
patch. The first patch is the currcon one that I posted earlier. Every
driver makes use of the currcon field in struct fb_info.  The second patch
makes every driver start to use fbgen. The first function that is mass
reproduced in every driver do_install_cmap is removed to one spot. I like
people to test this before it is sent off to Dave Jones. The patches are
big so here is the link to them:

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

http://www.transvirtual.com/~jsimmons/fbcurrcon.diff
http://www.transvirtual.com/~jsimmons/doinstallcmap.diff

Have fun. I have tested on my local machine. Works like a charm. 

