Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbTI3NsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTI3NsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:48:10 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:32730 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261495AbTI3NsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:48:04 -0400
Date: Tue, 30 Sep 2003 15:44:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20030930134453.GA25198@ucw.cz>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030928085902.GA3742@k3.hellgate.ch> <20030929151643.GA15992@ucw.cz> <20030930075024.GA1620@squish.home.loc> <20030930125126.GA24122@ucw.cz> <20030930132134.GA17242@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930132134.GA17242@cathedrallabs.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:21:34AM -0300, Aristeu Sergio Rozanski Filho wrote:

> > This is because it is the same as on the latest 2.4 kernel. 2.6 used
> > software autorepeat up to test6. Now, because of hardware bugs, it was
> > necessary to switch back to hardware autorepeat, like 2.4 uses.
> and it fixes the problem with my notebook's keyboard, thanks :)

What problem exactly was that?

> > Interesting. This probably has much to do with mouse acceleration
> > settings. What was done was that the mouse report rate was made LOWER
> > (60 compared to 200) to cure problems with some systems that couldn't
> > handle the high report rate.
> > 
> > This makes the movement per report larger and thus the acceleration
> > formula in XFree then works more aggressively.

> test6 was the first 2.5/2.6 kernel that psmouse_noext=1 wasn't necessary
> to make my synaptics touchpad work. but i noticed it's much more
> sensible (with leads to be very difficult to hit xmms' pause button :)
> than using it with noext option. is anyone working in an user level
> application to configure 2.6's synaptics touchpad driver?

Have you tried the

	http://w1.894.telia.com/~u89404340/touchpad/index.html

XFree86 driver?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
