Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129840AbRB0MAS>; Tue, 27 Feb 2001 07:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRB0MAI>; Tue, 27 Feb 2001 07:00:08 -0500
Received: from ns1.whiterose.net ([208.155.122.237]:9998 "HELO
	ns1.whiterose.net") by vger.kernel.org with SMTP id <S129840AbRB0L75>;
	Tue, 27 Feb 2001 06:59:57 -0500
Date: Tue, 27 Feb 2001 06:56:02 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre14 is marked as pre13, plus some config/other
 problems. (fwd)
Message-ID: <Pine.BSF.4.21.0102270655440.49899-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> A). The version of the linux 2.2.19pre14 on 2.2.18
>     is compiling and saying it is pre13. Thus the
>     make file has the wrong version.

Yep. Harmless

> B). After doing "make menuconfig". The textboxes
>     displayed for the menu options "Processor family"
>     and "Maximum Physical memory" are displayed
>     incorrectly (half missing). 
>     If I move the keyboard cursor arrow up and down
>     for each of the above menus, then the display is
>     redrawn with all of the missing menu options, color
>     and graphics. Note: I have libcurses v5.0beta1 which
>     didn't have problems in linux 2.2.19pre5 or earlier.

I cant support beta curses libraries. The code was changed so that the 
hardware cursor accurately reflected the position of the menu item. That is
vital to blind users

> C). Errors during "make dep". 
>     note: I have md5sum from textutils v1.22.
>     If my config file will help here, I can send it.

The md5sum one is also ok. The ISDN code in 2.2.19pre14 isnt certified or
intended to be

Alan

