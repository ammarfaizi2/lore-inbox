Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUJDH0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUJDH0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 03:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJDH0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 03:26:30 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:5518 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S268496AbUJDH02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 03:26:28 -0400
Date: Mon, 4 Oct 2004 09:26:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange 2.6.9-rc3 keyboard repeat behavior
Message-ID: <20041004072612.GA2712@ucw.cz>
References: <415C8D7F.3020505@pobox.com> <20041001071323.GA5779@ucw.cz> <4160CA56.3040703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4160CA56.3040703@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 11:58:14PM -0400, Jeff Garzik wrote:

> Vojtech Pavlik wrote:
> >On Thu, Sep 30, 2004 at 06:49:35PM -0400, Jeff Garzik wrote:
> >
> >>After booting into 2.6.9-rc3 release kernel, I am seeing strange and 
> >>annoying keyboard repeat behavior.
> >>
> >>If I hold down a single key, while in X, the character will repeat at 
> >>the expected (2.6.9-rc2 and prior) rate... for 1 second.
> >>
> >>After 1 second, the keyboard repeat rate slows to half or more.
> >>
> >>Can we please fix this?  Config attached.
> >
> >
> >How does it behave on the console? The problem is that X generates its
> >own software autorepeat and ignores what the kernel feeds it. So I
> >suppose this might be more a gettimeofday or scheduling problem than one
> >with the input layer.
> 
> 
> Confirmed, console keyboard repeat does not show this behavior.
> 
> However...  this behavior does goes away when I boot an earlier kernel.
 
Can you try to replace just the drivers/input sub-tree?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
