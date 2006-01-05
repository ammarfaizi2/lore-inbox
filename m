Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWAECkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWAECkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWAECkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:40:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932166AbWAECkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:40:41 -0500
Date: Wed, 4 Jan 2006 18:40:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.15
In-Reply-To: <20060105020742.GA18815@suse.de>
Message-ID: <Pine.LNX.4.64.0601041836370.3279@g5.osdl.org>
References: <20060105004826.GA17328@kroah.com> <Pine.LNX.4.64.0601041724560.3279@g5.osdl.org>
 <20060105020742.GA18815@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jan 2006, Greg KH wrote:
> > 
> > I can do the trivial manual fixup, but when I do, I have two copies of 
> > "usb_match_id()": one in drivers/usb/core/driver.c and one in 
> > drivers/usb/core/usb.c.
> > 
> > I've pushed out my tree, so that you can see for yourself (it seems to 
> > have mirrored out too).
> 
> Yeah, I was wondering how that would merge together, I'll take a look at
> the tree after dinner and fix up the problem (there should only be one
> copy of that function.)

Actually, looking closer, my first trivial merge was wrong (it took the 
code from both branches), and doing it right seems to get the proper 
results (with just one usb_match_id() function).

I'll push out my _proper_ trivial merge fixup, please just verify that the 
end result looks sane and matches what you have.

		Linus
