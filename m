Return-Path: <linux-kernel-owner+w=401wt.eu-S1751046AbXAOQog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbXAOQog (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXAOQof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:44:35 -0500
Received: from twin.jikos.cz ([213.151.79.26]:53703 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbXAOQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:44:35 -0500
Date: Mon, 15 Jan 2007 17:44:26 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Simon Budig <simon@budig.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for
 SpaceNavigator)
In-Reply-To: <20070115162541.GA3751@budig.de>
Message-ID: <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz>
 <20070115162541.GA3751@budig.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Simon Budig wrote:

> > thanks for the patch. It seems that it is based on pre-2.6.20-rc1 kernel 
> > (this is where the USBHID split happened and generic HID layer was 
> > introduced). Could you please rebase it against newer version of kernel 
> > and resend it?
> I've updated the patch, will submit it to the list in a few minutes.

I got it, thanks.

> > All your changes happen to be in the transport-independent code, so it 
> > seems that this would be rather trivial task - probably only pathnames 
> > (and diff offsets) will change - your changes should now go to 
> > drivers/hid/hid-*, not drivers/usb/input/hid-*.
> Yeah, it was easy to port over. Did the hid-debug stuff disappear
> completely? What would I use instead?

No, it didn't disappear, it was just moved to include/linux/hid-debug.h. 
Should I wait for an updated patch that uses hid-debug.h again?

Thanks,

-- 
Jiri Kosina
