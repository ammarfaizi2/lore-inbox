Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVBNUbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVBNUbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVBNUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:31:42 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:39581 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261437AbVBNUbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:31:40 -0500
Date: Mon, 14 Feb 2005 21:32:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050214203211.GA8007@ucw.cz>
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214105837.GE3233@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 11:58:37AM +0100, Stelian Pop wrote:

> > Stelian Pop <stelian@popies.net> wrote:
> > 
> > > Privately I've had many positive feedbacks from users of this driver
> > > (and no negative feedback), including Linux distributions who wish
> > > to include it into their kernels. The reports are increasing in number,
> > > it would seem that newer Sony Vaios are more and more incompatible
> > > with sonypi and require sony_acpi to control the screen brightness.
> > 
> > The sonypi driver seems to be necessary to catch Vaio hotkey events,
> > including the sleep button. I've checked a couple of DSDTs, and it seems
> > that the more recent Vaios are lacking the SPIC entries but still don't
> > have the sleep button defined. Is there any chance of this driver being
> > able to catch hotkey events?
> 
> I don't believe so.
> 
> > Related to that, I have a nastyish hack which lets the sonypi driver
> > generate ACPI events whenever a hotkey is pressed. Despite not strictly
> > being ACPI events, this makes it much easier to integrate sonypi stuff
> > with general ACPI support. I'll send it if you're interested.
> 
> Wouldn't be more useful to make the ACPI hotkeys generate an
> input event (like sonypi does) and integrate all this at the input
> level ?
 
Yes, I'd like to see that. The other possible way is have the input
layer generate ACPI events for power-related keys.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
