Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWF0TQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWF0TQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWF0TQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:16:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932543AbWF0TQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:16:40 -0400
Date: Tue, 27 Jun 2006 12:16:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net>
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org> <20060627063734.GA28135@kroah.com>
 <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Linus Torvalds wrote:
> 
> > What does the kernel log show right before this happened?
> > Any chance to enable CONFIG_USB_DEBUG?
> 
> Will try.

There were _no_ kernel messages just before the oops. Not even with USB 
debugging turned on. Of course, they may have been marked "informational", 
and not shown on the console. Every distribution seems to think that debug 
messages are more annoying than useful, so they tend to set the console 
debug level down (even if you boot with "debug" to turn it on!). Gaah!

		Linus
