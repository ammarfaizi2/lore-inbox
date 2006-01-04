Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWADKem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWADKem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWADKel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:34:41 -0500
Received: from styx.suse.cz ([82.119.242.94]:23703 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751655AbWADKel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:34:41 -0500
Date: Wed, 4 Jan 2006 11:34:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: usb/input: Split into separate layers (was: Re: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h)
Message-ID: <20060104103423.GB7168@corona.suse.cz>
References: <20060102233730.GA29826@hansmi.ch> <200601030142.32623.dtor_core@ameritech.net> <20060103195344.GC6443@corona.home.nbox.cz> <20060103221133.GA13921@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103221133.GA13921@hansmi.ch>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 11:11:33PM +0100, Michael Hanselmann wrote:
> Hello Vojtech
> 
> On Tue, Jan 03, 2006 at 08:53:44PM +0100, Vojtech Pavlik wrote:
> > We should split HID in two parts - transport and decoding. This would
> > help in many places:
> > [...]
> 
> > I don't have the time to do the split myself, but it shouldn't be too
> > hard.
> 
> And for myself, I think I'm not enough into kernel development already.
> Beside of that, USB isn't my very interest but those patches had to be
> done to get the new PowerBook models running smooth. Hopefully there's
> someone else interested in doing the split because it would be a good
> thing.
> 
> > It would not be the perfect solution for Apple keyboards, [...]
> 
> Does that mean the patch doesn't get into the kernel until the split
> happened?
 
No, I'm fine with the patch going in, but it can be removed and redone
as a separate HID parser if the split happens.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
