Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTI1JtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 05:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTI1JtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 05:49:14 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:42393 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261239AbTI1JtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 05:49:14 -0400
Date: Sun, 28 Sep 2003 11:49:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matt Gibson <gothick@gothick.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Message-ID: <20030928094909.GA21009@ucw.cz>
References: <10645086121286@twilight.ucw.cz> <20030927211838.GC360@elf.ucw.cz> <20030927212116.GA18445@ucw.cz> <200309272258.05132.gothick@gothick.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309272258.05132.gothick@gothick.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 10:58:05PM +0100, Matt Gibson wrote:
> On Saturday 27 Sep 2003 22:21, Vojtech Pavlik wrote:
> > Yes, exactly so. We may have similar problems with differentiation
> > elsewhere (touchpad vs 6dof device), so we'll probably need the 'class'
> > field.
> 
> I don't know if this is relevant, but there are some devices which can work 
> in either relative (like a touchpad) or absolute (like a touchscreen) mode.  
> For example, using a combination of the kernel and the X drivers, at the 
> moment I have my Wacom tablet working in relative mode when I'm using its 
> mouse, but absolute mode when I'm using its pen.
> 
> I'm wondering whether we don't so much need a device class, as something to 
> say whether the device works in absolute or relative mode, and that possibly 
> we might have devices where this could be dynamically changed.

That's a pretty neat idea, actually. Thanks!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
