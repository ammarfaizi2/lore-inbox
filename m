Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUBPOfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUBPOfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:35:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:39810 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265667AbUBPOfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:35:43 -0500
Date: Mon, 16 Feb 2004 15:36:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Emmeran Seehuber <rototor@rototor.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Message-ID: <20040216143617.GA959@ucw.cz>
References: <200402112344.23378.rototor@rototor.de> <200402151425.15478.rototor@rototor.de> <200402151028.25284.dtor_core@ameritech.net> <200402161334.43583.rototor@rototor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402161334.43583.rototor@rototor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 01:34:43PM +0000, Emmeran Seehuber wrote:

> On Sunday 15 February 2004 15:28, Dmitry Torokhov wrote:
> [...]
> >
> > I see that the kernel correctly identifies both devices so I suspect there
> > could be a problem with your setup. Could you also post your XF86Config
> > and tell me the the options you are passing to GPM, please?
> What I forgot to mention: cat /dev/input/mouse1 gives me some garbage as soon 
> as I move on the trackpad. But cat /dev/input/mouse0 gives me nothing, so I 
> don't think that this is a userspace configuration problem. The kernel seems 
> to get no input from the PS/2 mouse at all.

Dmitry, this looks like either MUX or PassThrough problem.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
