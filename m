Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290784AbSAYSq4>; Fri, 25 Jan 2002 13:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290783AbSAYSql>; Fri, 25 Jan 2002 13:46:41 -0500
Received: from www.transvirtual.com ([206.14.214.140]:5638 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290779AbSAYSpy>; Fri, 25 Jan 2002 13:45:54 -0500
Date: Fri, 25 Jan 2002 10:45:47 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] screen_base now in struct fb_info
Message-ID: <Pine.LNX.4.10.10201251042280.557-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I moved screen_base from struct display to struct fb_info. This is for teh
further seperation of the fbdev layer from fbcon to make the code smaller
and cleaner. The patch is pretty big. It is against Dave jones 2.5.2-dj5
tree. Please try it out. I like to submit a patch that works perfect. 


http://www.transvirtual.com/~jsimmons/screen_base.diff

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

