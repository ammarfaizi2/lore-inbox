Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264882AbSJ3Umt>; Wed, 30 Oct 2002 15:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSJ3Ums>; Wed, 30 Oct 2002 15:42:48 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:41620 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264882AbSJ3Ums>; Wed, 30 Oct 2002 15:42:48 -0500
Date: Wed, 30 Oct 2002 13:42:21 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [BK fbdev updates]
Message-ID: <Pine.LNX.4.33.0210301331210.1392-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  The latest changes to the framebuffer layer are avaiable to be merged.
The changes include the final removal of all console related code in the
low level drivers. This allows for a very simple api. Also with this
design is to possible to run a test/debug a fbdev driver without the
framebuffer console. We can use another console system to see the results
of what we have done. This will allow greater speed at developing a new
driver because of the new simple api and the new approaches at
debugging them. Please merge with your tree.

bk://fbdev.bkbits.net/fbdev-2.5


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

