Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbTI3N0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTI3NZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:25:01 -0400
Received: from panda.sul.com.br ([200.219.150.4]:11535 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id S261375AbTI3NYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:24:52 -0400
Date: Tue, 30 Sep 2003 10:21:34 -0300
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20030930132134.GA17242@cathedrallabs.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030928085902.GA3742@k3.hellgate.ch> <20030929151643.GA15992@ucw.cz> <20030930075024.GA1620@squish.home.loc> <20030930125126.GA24122@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930125126.GA24122@ucw.cz>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is because it is the same as on the latest 2.4 kernel. 2.6 used
> software autorepeat up to test6. Now, because of hardware bugs, it was
> necessary to switch back to hardware autorepeat, like 2.4 uses.
and it fixes the problem with my notebook's keyboard, thanks :)

> Interesting. This probably has much to do with mouse acceleration
> settings. What was done was that the mouse report rate was made LOWER
> (60 compared to 200) to cure problems with some systems that couldn't
> handle the high report rate.
> 
> This makes the movement per report larger and thus the acceleration
> formula in XFree then works more aggressively.
test6 was the first 2.5/2.6 kernel that psmouse_noext=1 wasn't necessary
to make my synaptics touchpad work. but i noticed it's much more
sensible (with leads to be very difficult to hit xmms' pause button :)
than using it with noext option. is anyone working in an user level
application to configure 2.6's synaptics touchpad driver?

thanks again for your effort

--
aris

