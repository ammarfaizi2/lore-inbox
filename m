Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262704AbTC0ALJ>; Wed, 26 Mar 2003 19:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbTC0ALJ>; Wed, 26 Mar 2003 19:11:09 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:31240 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262688AbTC0ALI>; Wed, 26 Mar 2003 19:11:08 -0500
Date: Thu, 27 Mar 2003 00:22:19 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Torrey Hoffman <thoffman@arnor.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sisfb: two more little problems
In-Reply-To: <1048723564.1156.5.camel@rohan.arnor.net>
Message-ID: <Pine.LNX.4.44.0303270021000.25001-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Besides the problems with mode switching with fbcon, I have two other
> problems with sisfb:
> 
> 1. My gpm mouse cursor on the framebuffer console is a cyan rectangle
> with a bright orange "G" in it.  Actually the G has a "^" accent over
> it.  That's just when it's over a blank spot.  When I move it over other
> characters, the character in the pointer changes.  However, it does work
> for selecting text.

Try my latest patch. It should fix this. 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Let me know how it works out for you.
 
> 2. I can't seem to set the default video mode from the kernel command
> line.  I have tried:
> 
> video=sis:1024x768-24@75
> video=sisfb:1024x768-24@75
> 
> and neither one works.  What is the expected command line?

It is video=sisfb:...

Hm. It should work. 

