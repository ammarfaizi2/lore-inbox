Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUEaUBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUEaUBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUEaUBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:01:01 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:52352 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264762AbUEaUA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:00:58 -0400
Date: Mon, 31 May 2004 22:01:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Pokey the Penguin <pokey@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse/usb interaction fix
Message-ID: <20040531200120.GA1747@ucw.cz>
References: <20040531174012.BA07D2B2B58@ws5-7.us4.outblaze.com> <20040531180341.GA17125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531180341.GA17125@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 11:03:42AM -0700, Greg KH wrote:

> > The patch is ported from a SuSE kernel to 2.6.7-rc2. It's been
> > around for at least two minor releases. The maintainer was
> > contacted regarding merging but failed to respond.
> > 
> > Patch vital to certain laptop users. Please apply.
> 
> But this breaks users who want BIOS usb support instead of native Linux
> support, right?  Sure, there are not many people who want that, but I do
> know people who rely on this (like installer kernels, and early boot
> issues with USB keyboards.)
 
I wrote the patch, SuSE 9.1 is shipping with it - too many BIOSes get
the USB support wrong - don't expect keyboards and mice which don't
honor the SET_IDLE command, etch. In my experience the BIOS USB support
causes much more pain than good, namely preventing the normal PS/2 mice
and keyboards to work properly.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
