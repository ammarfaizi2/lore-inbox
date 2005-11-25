Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKYIWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKYIWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 03:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKYIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 03:22:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:11748 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750746AbVKYIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 03:22:54 -0500
Date: Fri, 25 Nov 2005 09:22:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Marc Koschewski <marc@osknowledge.org>,
       Ed Tomlinson <tomlins@cam.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Message-ID: <20051125082253.GA13959@ucw.cz>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <20051124124444.GA23667@stiffy.osknowledge.org> <200511242124.00127.rjw@sisk.pl> <200511242220.25702.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511242220.25702.rjw@sisk.pl>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 10:20:25PM +0100, Rafael J. Wysocki wrote:
> Update:
> 
> On Thursday, 24 of November 2005 21:23, Rafael J. Wysocki wrote:
> > On Thursday, 24 of November 2005 13:44, Marc Koschewski wrote:
> > }-- snip --{
> > > > It looks like you are seeing a different bug.  The one opened for debian user space
> > > > covers mousedev not being loaded if the kernel is 2.6.15, which leads to no /dev/input
> > > > 
> > > 
> > > That's what I think, thus the report on LKLM. But noone but me seems to
> > > be trapped into it until... :/
> > 
> > FWIW, my touchpad doesn't work with -rc2-mm1 too (usually I use a USB mouse,
> > so I didn't notice before).  Here's what dmesg says about it:
> > 
> > Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
> > input: SynPS/2 Synaptics TouchPad as /class/input/input2
> > 
> > The box is an Asus L5D (x86-64).
> 
> Actually, it works on the console (ie with gpm), but X is unable to use it,
> apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
> non-mm kernel I've been able to test quickly on this box).
> 
> Marc, does your touchpad work with gpm?
 
What's in your relevant xorg.conf sections?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
