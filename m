Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268176AbUIKPok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268176AbUIKPok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUIKPok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:44:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28595 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268176AbUIKPmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:42:36 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: adaplas@pol.net
Cc: Dave Airlie <airlied@linux.ie>,
       Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200409111720.38477.adaplas@hotpop.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <200409111720.38477.adaplas@hotpop.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094913600.21088.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 15:40:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 10:20, Antonino A. Daplas wrote:
> In theory, one can have a process (kernel or userland) change the video
> mode, then provide the in-kernel driver with the necessary information
> about the layout of the framebuffer.  When this in-kernel driver gets the
> necessary information, it can trigger fbcon. This in-kernel driver need not
> know anything about the hardware (unless 2D acceleration is needed).

Thats great because one of the things X wants to tell DRI to tell the
kernel eventually is "by the way the area visible is laid out like this
shoudl you want to panic on it".

(Jon wants to move the mode setting out of X eventually and that follows
the same line of requirement nicely).

