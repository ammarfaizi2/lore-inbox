Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUJASI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUJASI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUJASGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:06:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:47289 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265971AbUJASBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:01:20 -0400
Date: Fri, 1 Oct 2004 11:01:01 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, "J.A. Magallon" <jamagallon@able.es>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20041001180101.GC14015@kroah.com>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <1096586774l.5206l.1l@werewolf.able.es> <20040930170505.6536197c.akpm@osdl.org> <200410010030.39826.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410010030.39826.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 12:30:39AM -0500, Dmitry Torokhov wrote:
> On Thursday 30 September 2004 07:05 pm, Andrew Morton wrote:
> > > One other question. Isn't /dev/input/mice supposed to be a multiplexor
> > > for mice ? I think I remember some time when I could have both a PS2 and
> > > a USB mouse connected and X pointer followed both. Now if I boot with the
> > > USB mouse plugged, the PS2 one does not work. If I boot with usb unplugged
> > > and plug it after boot, both work; usb mouse works fine, and PS2 just
> > > jumps half screen each time I move it, and with big delays.
> > > 
> > 
> 
> I bet it's USB legacy emulation topic again. Try loading USB modules first
> and then psmouse, should help.
> 
> Vojtech, what is the status of USB handoff patches. I have seen several
> variants and so far heard only success stories from people using them. Can
> we have them in kernel proper?

They are already in the -mm tree, but they need to be explicitly enabled
with a boot command line option to have the handoff happen.

thanks,

greg k-h
