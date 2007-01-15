Return-Path: <linux-kernel-owner+w=401wt.eu-S1751137AbXAOSc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbXAOSc3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXAOSc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:32:29 -0500
Received: from styx.suse.cz ([82.119.242.94]:48998 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751137AbXAOSc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:32:28 -0500
Date: Mon, 15 Jan 2007 19:32:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Simon Budig <simon@budig.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115183207.GA6792@suse.cz>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz> <20070115162541.GA3751@budig.de> <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 05:44:26PM +0100, Jiri Kosina wrote:
> On Mon, 15 Jan 2007, Simon Budig wrote:
> 
> > > thanks for the patch. It seems that it is based on pre-2.6.20-rc1 kernel 
> > > (this is where the USBHID split happened and generic HID layer was 
> > > introduced). Could you please rebase it against newer version of kernel 
> > > and resend it?
> > I've updated the patch, will submit it to the list in a few minutes.
> 
> I got it, thanks.
> 
> > > All your changes happen to be in the transport-independent code, so it 
> > > seems that this would be rather trivial task - probably only pathnames 
> > > (and diff offsets) will change - your changes should now go to 
> > > drivers/hid/hid-*, not drivers/usb/input/hid-*.
> > Yeah, it was easy to port over. Did the hid-debug stuff disappear
> > completely? What would I use instead?
> 
> No, it didn't disappear, it was just moved to include/linux/hid-debug.h. 

Do you think that makes sense? It's code, not a header file.

> Should I wait for an updated patch that uses hid-debug.h again?

-- 
Vojtech Pavlik
Director SuSE Labs
