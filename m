Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUANX5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUANX5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:57:25 -0500
Received: from [24.35.117.106] ([24.35.117.106]:36482 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266431AbUANX5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:57:22 -0500
Date: Wed, 14 Jan 2004 18:57:06 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Greg Stark <gsstark@mit.edu>
cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: No mouse wheel under 2.6.1 [Was: Re: Where are 2.6.x upgrade
 notes?]
In-Reply-To: <873caj0y96.fsf_-_@stark.xeocode.com>
Message-ID: <Pine.LNX.4.58.0401141850350.5237@localhost.localdomain>
References: <87ptdocmf1.fsf@stark.xeocode.com> <003801c3d9c4$2c2dead0$0e25fe0a@southpark.ae.poznan.pl>
 <873caj0y96.fsf_-_@stark.xeocode.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Jan 2004, Greg Stark wrote:

> "Maciej Soltysiak" <solt@dns.toxicfilms.tv> writes:
> 
> > > Upgrade FAQ somewhere like there was with 2.4?
> >
> > Kind of, yes. A lengthy document, but still...
> > I think the 'Known Gotchas' section could be extended by
> > new problems that might appear. ALSA being muted issue
> > is not included there.
> 
> Well I think ALSA being muted will catch lots of people. As luck would have it
> it was the one thing I knew about in advance and it didn't help. As far as I
> can tell the Alsa i810 driver just doesn't produce audio at all. I tried both
> the kernel source and the 1.0.1 source. Thankfully the OSS drivers still work.

I am using ALSA with 2.6.  I needed to enable the OSS emulation API to get 
sound working for me.  

 
> But I'm still stuck with no mouse wheel. I'm really weirded out by this. I've
> tried both /dev/psaux and /dev/input/mouse0 and neither allow X to receive
> anything for the mouse wheel. 
> 
> I'm using protocol MousemanPlusPS/2 with this logitech M-C48 mouse, which has
> always worked fine in the past. I just verified it still works fine under
> 2.4.23pre4 with the same version of X.
> 
> Does it work for anyone else?

I have a Logitech cordless optical mouse.  I run it with IMPS/2 protocol 
in both console and X mode.  My XF86Config shows mouse input devices at 
/dev/psaux and /dev/input/mice.
