Return-Path: <linux-kernel-owner+w=401wt.eu-S1750994AbXAOQZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXAOQZo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbXAOQZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:25:43 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:45833 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXAOQZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:25:43 -0500
Date: Mon, 15 Jan 2007 17:25:41 +0100
From: Simon Budig <simon@budig.de>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115162541.GA3751@budig.de>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina (jikos@jikos.cz) wrote:
> thanks for the patch. It seems that it is based on pre-2.6.20-rc1 kernel 
> (this is where the USBHID split happened and generic HID layer was 
> introduced). Could you please rebase it against newer version of kernel 
> and resend it?

I've updated the patch, will submit it to the list in a few minutes.

> All your changes happen to be in the transport-independent code, so it 
> seems that this would be rather trivial task - probably only pathnames 
> (and diff offsets) will change - your changes should now go to 
> drivers/hid/hid-*, not drivers/usb/input/hid-*.

Yeah, it was easy to port over. Did the hid-debug stuff disappear
completely? What would I use instead?

Thanks,
         Simon
-- 
              simon@budig.de              http://simon.budig.de/
