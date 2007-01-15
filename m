Return-Path: <linux-kernel-owner+w=401wt.eu-S1750822AbXAOVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXAOVOP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbXAOVOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:14:15 -0500
Received: from twin.jikos.cz ([213.151.79.26]:43688 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbXAOVOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:14:14 -0500
Date: Mon, 15 Jan 2007 22:14:07 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Simon Budig <simon@budig.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for
 SpaceNavigator)
In-Reply-To: <20070115173216.GA4582@budig.de>
Message-ID: <Pine.LNX.4.64.0701152210530.16747@twin.jikos.cz>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz>
 <20070115162541.GA3751@budig.de> <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
 <20070115173216.GA4582@budig.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Simon Budig wrote:

> Is it possible that there is a regression in the hid-debug stuff? The
> mapping does not seem to appear in the dmesg-output. I unfortunately
> don't have an earlier kernel available right now to verify, but now the
> output on plugging in the device looks like this:

Hi Simon,

thanks, I queued the LED mapping fix for upstream.

I agree with Vojtech and Marcel that it doesn't make much sense having the 
hid-debug as a header file - I will fix it, and apply your patch to it 
(after I check why the debug output seems to be broken), you don't have to 
resend it, thanks.

-- 
Jiri Kosina
