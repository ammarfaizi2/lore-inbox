Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVBFSnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVBFSnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBFSlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:41:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:19593 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S261268AbVBFSlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:41:03 -0500
Date: Sun, 6 Feb 2005 19:41:20 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org, lineak-devel@lists.sourceforge.net
Subject: Re: Linux input event extending tool exist?
Message-ID: <20050206184120.GH23126@ucw.cz>
References: <200412101638.05125.aivils@unibanka.lv> <20041210142044.GB20511@ucw.cz> <41C11202.2040009@lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C11202.2040009@lammerts.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 11:41:38PM -0500, Eric Lammerts wrote:
> Vojtech Pavlik wrote:
> >You can use evtest (attached). It's often found in the joystick RPMs.
> >It's also in the linuxconsole.sf.net CVS repository.  On recent kernels
> >it'll show the scancodes as well as the generated keycodes.
> 
> Vojtech, are you aware that this doesn't work well with 32-bit apps on 
> x86-64 kernels? The ioctls don't work (no compat definitions), and 
> struct input_event is 24 bytes instead of 16.
 
Yes, I do. It's a bug, and will be a hard one to solve. The ioclt()s are
easy, but the event size difference is pretty nasty.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
